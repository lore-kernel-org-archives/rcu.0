Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3111122098
	for <rcu@vger.kernel.org>; Sat,  2 Dec 2023 23:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBA2C433C8;
	Sat,  2 Dec 2023 23:45:10 +0000 (UTC)
Date: Sat, 2 Dec 2023 18:45:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org, Frederic
 Weisbecker <fweisbec@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RCU] rcu_tasks_trace_qs(): trc_reader_special.b.need_qs value
 incorrect likely()?
Message-ID: <20231202184507.26178c17@rorschach.local.home>
In-Reply-To: <b0772bf3-5b47-4aea-b964-17a2bebc6313@paulmck-laptop>
References: <20231201154932.468d088b@gandalf.local.home>
	<b0772bf3-5b47-4aea-b964-17a2bebc6313@paulmck-laptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Dec 2023 14:24:26 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > Note, the unlikely tracing is running on my production server v6.6.3.
> > 
> > The above trace is from my test box with latest Linus's tree.  
> 
> Nice tool!!!

Thanks! It's only been in the kernel since 2008 ;-)

  1f0d69a9fc815 ("tracing: profile likely and unlikely annotations")

> 
> My kneejerk reaction is that that condition is suboptimal.  Does the 
> (untested) patch below help things?

I'll give it a try on Monday.

Thanks,

-- Steve
