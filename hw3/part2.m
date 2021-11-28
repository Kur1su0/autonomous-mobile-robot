clear;
close all;
clc;

ROTATION_RATE = 0.09;%rad/s
FORWARD_RATE = 1.5;

SENSOR_SIGMA_SQUARE = 8;
FORWARD_SIGMA_SQUARE = 0.5;
TURN_SIGMA_SQUARE = pi*0.5/180;

LANDMARKS = [25 25 ;25 70 ;70 25;  70 70; 10 40 ; 80 60];
Robot_init= [50+randomNum(-5,5), 50+ randomNum(-5,5), randomNum(0,2*pi)];
% init random particles
N = 1000;

% r1 = unifrnd(a1,b1)
particles = zeros(N,3);
particles(:,1) = 100*rand(N,1);
particles(:,2) =100*rand(N,1);
particles(:,3) = 2*pi*rand(N,1);

%init robot

robot_est_pos(1,:) = mean(particles);
robot_true_pos(1,:) = Robot_init;




dist_error(1) = sqrt((robot_est_pos(1,1)-robot_true_pos(1,1))^2 + (robot_est_pos(1,2)-robot_true_pos(1,2))^2  );
theta_error(1) = abs(robot_est_pos(1,3)-robot_true_pos(1,3));


% print landmark
% for i = 1 : length(LANDMARKS)
%     scatter(LANDMARKS(i,1),LANDMARKS(i,2),'r')
% end
% 
% for i = 1 : length(particles)
%     scatter(particles(i,1),particles(i,2),'g.')
% end
% scatter(Robot_init(1),Robot_init(2),'bx')
% scatter(robot_est_pos(1),robot_est_pos(2),'bx')

nsteps = 10;
for i=1:nsteps
    %% update true pos and particle
    % true pos
    new_turn = mod(ROTATION_RATE+robot_true_pos(i,3)+ normrnd(0,sqrt(TURN_SIGMA_SQUARE)),2*pi);
    new_forward = FORWARD_RATE + normrnd(0,sqrt(FORWARD_SIGMA_SQUARE));
    robot_true_pos(i+1,1) =  robot_true_pos(i,1) + cos(new_turn).*new_forward;
    robot_true_pos(i+1,2) =  robot_true_pos(i,2) + sin(new_turn).*new_forward;
    robot_true_pos(i+1,3) =  new_turn;
    
    % particle
    new_particle = zeros(N,3);
    particle_turn =  mod(ROTATION_RATE + particles(:, 3) + normrnd(0,sqrt(TURN_SIGMA_SQUARE)), 2*pi);
    particle_forward = FORWARD_RATE + normrnd(0,sqrt(FORWARD_SIGMA_SQUARE),N,1);
    new_particle(:,1) = particles(:, 1) + cos(particle_turn).*particle_forward;
    new_particle(:,2) = particles(:, 2) + sin(particle_turn).*particle_forward;
    new_particle(:,3) = particle_turn;
    
    %% get Distance
    measurement_dist = [];
    for j=1:size(LANDMARKS,1)
        temp_dist = sqrt( (LANDMARKS(j,1) - robot_true_pos(i+1,1))^2+(LANDMARKS(j,2) - robot_true_pos(i+1,2))^2 );
        noise = normrnd(0,sqrt(SENSOR_SIGMA_SQUARE));
        measurement_dist(j) = temp_dist + noise;
    end
    weight = zeros(N,1);
    %% update weight
    for j=1:N
        prob = 1;
        
        for k=1:size(LANDMARKS,1)
            disti = sqrt( (new_particle(j,1)-LANDMARKS(k,1)  )^2 + (new_particle(j,2)-LANDMARKS(k,2)  )^2 );
             gaussian = (1/(sqrt(2*pi*SENSOR_SIGMA_SQUARE))) *exp( -0.5 *((measurement_dist(k)-disti)/SENSOR_SIGMA_SQUARE)^2);
             
 
            prob = prob * gaussian;
        end
        weight(j) = prob;
        
    end
    weight=weight/sum(weight);
    
    %% resampling
    resampled_particles = zeros(N,3);
    index = randi(N,1);
    beta = 0;
    for j=1:N
        beta = beta + rand()*2*max(weight);
        while beta > weight(index)
            beta = beta - weight(index);
            index = mod(index+1,N+1);
            if index == 0
                index = 1;
            end
        end
        resampled_particles(j,:) = new_particle(index,:);
    
    end
    
    %estimate
    particles  = resampled_particles;
    robot_est_pos(i+1,:) = mean(particles);
 
    
    dist_error(i+1) = sqrt((robot_est_pos(i+1,1)-robot_true_pos(i+1,1))^2 + (robot_est_pos(i+1,2)-robot_true_pos(i+1,2))^2  );
    theta_error(i+1) = abs(robot_est_pos(i+1,3)-robot_true_pos(i+1,3));
    disp(['#inter',num2str(i)]);
    disp(['dist error ',num2str(dist_error(i+1))]);
    disp(['abs theta error ',num2str(theta_error(i+1))]);
    disp(['pose (x,y,theta) ',num2str(robot_est_pos(i+1,:))]);
    
   end
 
    %% plot
  
    
 
    subplot(1,2,1)
     hold on
    grid on
    title("pose")
    recBot_est = recBot(robot_est_pos(i,1),robot_est_pos(i,2),robot_est_pos(i,3));
    recBot_true = recBot(robot_true_pos(i,1),robot_true_pos(i,2),robot_true_pos(i,3));

    plot(recBot_est(1,1),recBot_est(1,2),'r.',recBot_est(1:2,1),recBot_est(1:2,2),'r-',recBot_est(3:end,1),recBot_est(3:end,2),'r--' ...
        ,recBot_true(1,1),recBot_true(1,2),'b.',recBot_true(1:2,1),recBot_true(1:2,2),'b-',recBot_true(3:end,1),recBot_true(3:end,2),'b-');
   
    for landmark = 1 : length(LANDMARKS)
        scatter(LANDMARKS(landmark,1),LANDMARKS(landmark,2),'k')
    end
    plot(robot_est_pos(:,1),robot_est_pos(:,2),'r--');
    plot(robot_true_pos(:,1),robot_true_pos(:,2),'b-');
%     scatter(robot_est_pos(i,1),robot_est_pos(i,2),'.');
    legend("","","est","","","real","landmarks");
     ylabel("x - m");
    xlabel("y - m");
xlim([0 100]);
ylim([0 100]);
axis square;
    hold off
    
    subplot(1,2,2)
    title("dist error & vel error")
    grid on
    axis( [0 14 0 20]);
    hold on
    plot(dist_error,'r');
    plot(theta_error,'b');
    ylabel("Dist - m");
    xlabel("#iterations");
    legend("dist error","abs theta error")
    hold off
    pause(0.1)



