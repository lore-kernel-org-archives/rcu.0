Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201466DCE6
	for <rcu@vger.kernel.org>; Tue,  5 Dec 2023 20:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4331CC433C7;
	Tue,  5 Dec 2023 20:59:01 +0000 (UTC)
Date: Tue, 5 Dec 2023 15:59:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org, Frederic
 Weisbecker <fweisbec@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RCU] rcu_tasks_trace_qs(): trc_reader_special.b.need_qs value
 incorrect likely()?
Message-ID: <20231205155927.4b3b9151@gandalf.local.home>
In-Reply-To: <20231202184507.26178c17@rorschach.local.home>
References: <20231201154932.468d088b@gandalf.local.home>
	<b0772bf3-5b47-4aea-b964-17a2bebc6313@paulmck-laptop>
	<20231202184507.26178c17@rorschach.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Dec 2023 18:45:07 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 2 Dec 2023 14:24:26 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > Note, the unlikely tracing is running on my production server v6.6.3.
> > > 
> > > The above trace is from my test box with latest Linus's tree.    
> > 
> > Nice tool!!!  
> 
> Thanks! It's only been in the kernel since 2008 ;-)
> 
>   1f0d69a9fc815 ("tracing: profile likely and unlikely annotations")
> 
> > 
> > My kneejerk reaction is that that condition is suboptimal.  Does the 
> > (untested) patch below help things?  
> 
> I'll give it a try on Monday.
> 

This looks to have caused a difference. Although there's other RCU
functions that need dealing with, but that's for when I have time to
analyze all the places that have bad annotations.


Anyway:

 correct incorrect  %        Function                  File              Line
 ------- ---------  -        --------                  ----              ----
 [..]
   17924        0   0 rcu_softirq_qs                 tree.c               247

Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
