Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3855A23
	for <rcu@vger.kernel.org>; Thu, 13 Jun 2024 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292759; cv=none; b=RBTNnrb4TM9Wt3S98M9yxSevUK6rA3jYpZfi6MaMVDydguVE/NnNye4mvayJIAHgew+EbifpHFggk3KH0nNkm62lMJQRQTe1AzBMaa5MRdWy2X298Qk5k24mMRPPFhegmg7ydCWOfdOYjXTs3skilL1W1Olv+J0pYsKk2I4ExAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292759; c=relaxed/simple;
	bh=da86AkFxHIkOc4tESz9ZsOeetZ6XG7V9OjcOgypTrw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQDal45byiitWpwgnmn+Lb9yHUMFSl6ZzdGAfv6DIYFqEbztelniRW/0z+RWZK3dxwZEKdOI2pmk+upSoTfR5b7uHBzjX/WxWo3vfFCiuJKCc6CAjVKrGPmfslaTLMTa/1BwHRQ+FYpRtSrORsyKx6d6D8jOLsbmnFstLXBwnbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0A6Hu0F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0A6Hu0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718292756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9rQScQ5vtt7eCN8eVf03+TDhuopk8F0T5btFX/XMq2I=;
	b=M0A6Hu0FjKqaZi4I9vDxW2xdzVoykHYJgZ3kF9IyinPb6qJxTfHd9Z/kNsLxFNuWA1iO39
	s6o+esnGq28Bw+xfVBr3FEszUPxLrwiZga93I1kxGOD5aHiZcxuTEEy12VzWH6Un39v4N/
	mfO4W8H9B2JzBYS/9lE2g1dYXPaZ2qU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-YWEh7EpZM0qs87FoGoJjPQ-1; Thu,
 13 Jun 2024 11:32:30 -0400
X-MC-Unique: YWEh7EpZM0qs87FoGoJjPQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1684E1913F51;
	Thu, 13 Jun 2024 15:32:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.233])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 841883000B64;
	Thu, 13 Jun 2024 15:31:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 13 Jun 2024 17:30:30 +0200 (CEST)
Date: Thu, 13 Jun 2024 17:30:22 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rachel Menge <rachelmenge@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Wei Fu <fuweid89@gmail.com>, apais@linux.microsoft.com,
	Sudhanva Huruli <Sudhanva.Huruli@microsoft.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Mike Christie <michael.christie@oracle.com>,
	Joel Granados <j.granados@samsung.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH] zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with
 TIF_SIGPENDING
Message-ID: <20240613153021.GC18218@redhat.com>
References: <1386cd49-36d0-4a5c-85e9-bc42056a5a38@linux.microsoft.com>
 <20240608120616.GB7947@redhat.com>
 <87a5jpqamx.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5jpqamx.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/13, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > kernel_wait4() doesn't sleep and returns -EINTR if there is no
> > eligible child and signal_pending() is true.
> >
> > That is why zap_pid_ns_processes() clears TIF_SIGPENDING but this is not
> > enough, it should also clear TIF_NOTIFY_SIGNAL to make signal_pending()
> > return false and avoid a busy-wait loop.
>
> I took a look through the code.  It used to be that TIF_NOTIFY_SIGNAL
> was all about waking up a task so that task_work_run can be used.
> io_uring still mostly uses it that way.  There is also a use in
> kthread_stop that just uses it as a TIF_SIGPENDING without having a
> pending signal.
>
> At the point in do_exit where exit_notify and thus zap_pid_ns_processes
> is called I can't possibly see a use for TIF_NOTIFY_SIGNAL.
> exit_task_work, exit_signals, and io_uring_cancel have all been called.
>
> So TIF_NOTIFY_SIGNAL should be spurious at this point and safe to clear.
> Why it remains set is a mystery to me.

because exit_task_work() -> task_work_run() doesn't clear TIF_NOTIFY_SIGNAL.

So yes, it is spurious, but to me a possible TIF_SIGPENDING is even more
"spurious". See my reply to Wei.

We don't need to clear TIF_NOTIFY_SIGNAL inside the loop, task_work_addd()
can't succeed after exit_task_work() sets ->task_works =&work_exited, but
this is another story and this doesn't (well, shouldn't) differ from
TIF_SIGPENDING.

> If I had infinite time and energy the ideal is to rework the pid
> namespace exit logic

Perhaps  in this case you could take a look at the next loop waiting for
pid_ns->pid_allocated == init_pids ;)

I always hated the fact that the the exiting sub-namespace init can
"hang forever" if this namespace has the tasks injected from the parent
namespace. And I had enough hard-to-debug internal bug reports which
blamed the kernel.

> This active waiting is weird and non-standard in the kernel and winds up
> causeing a problem every couple of years because of that.

Agreed.

Oleg.

