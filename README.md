# Graduation Grade

Application that help you to make prediction about your graduation grade.

## Project goal

During my last semester of bachelor degree, I was worried about my mark average, because I wanted to
finish with a great graduation grade.

I started to make predictions about how the last exams could go and how changes in this could modify
my average. But using only the calculator, this operation was really boring because I had to 
recalculate the average with all the marks every time. So, since I wanted to learn how to develop a
mobile application, I had the idea to create an application that can be useful to every university
student that want to make predictions about his own graduation grade.

Graduation Grade allows you to calculate your graduation grade by entering your marks and modifying
them, with a very simple and quick interface.

## Project description

This application is developed using the dart language and the Flutter framework. This is because,
even if this application is launched only on Google Play Store, if in the future I will have the 
time and the possibility to test this application with iOS device, my intention is to launch
Graduation Grade also in Apple App Store.

I used the MVC pattern in order to manage the communications between internal logic and user 
interface. This is really useful, because it helped me a lot to create a scalable and well defined
structure for this this project.
The MVC pattern is supported also by Observable pattern, to handle the notification between Model, 
View and Controller, and by Command pattern in order to create a very scalable process that is able
to control its behavior when different types of event happen during the usage of the application.
Finally, I used the Cubit pattern, which is a pattern that allows me to update the user interface
when an event happens through the emission of state relative to that event.

I decided to write the test only for the classes useful for the internal logic of the model and for
the pattern template that do not contains code about View for these reasons:
- I do not have enough time, because of university and thesis internship
- I am currently not interested in learn how to run test for Flutter UI, because with this project I
  understand that I do not want to work on front-end.
- I was more interested in testing the part responsible to calculate the graduation grade and to 
  manage the exams' mark, in order to ensure correct results and to help students with this task.
  
## Download
Google Play Store: [Graduation Grade](https://pages.github.com/)
