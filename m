Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F82114884D
	for <rcu@vger.kernel.org>; Thu, 13 Jun 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290941; cv=none; b=dEtnHVxuwrjm9Vpd3NA2IZxUx+WLFdt3ZN+qNr50J/OCvTJVNjGATu8q9EmbEW5ZL8eobf/gCMT4VjE06CERwJZAR+9MW7KxeDVccpLwK18B9gRyT7WsZmOhAyOZWNmE/25JcQGBU0Ca+7LH2Hm4thaCBOsA9PGHb7ViDlwS50c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290941; c=relaxed/simple;
	bh=vR9NwaM4K/cYj+QcW2JvRTu9+uSVsH0EXb3Y1Iv1cYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoLSe4W+d42U+PAJ4JkA7hxWUbBUWss3KaHu7/2k+IN/Sl+2JydFsR65cmX2c3tQaumZ5WkedZDWmZMzU3+AJsSiuFUBp5VaLNlwlMMrwlHTsXg/6y7ukUnFraAOc1h7tkDPZgB7rRrV8ZfrOavjxvDUBZvaK143IgUsfv+lexs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5vzMw+9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5vzMw+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718290939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsGjIQ/eoSOVrd1/81v2Gd3TZB10IZEXVzo2atMoutM=;
	b=W5vzMw+96YPCuq2/hgaXYXC3Gzq4TiyXWJnKNlugEdrbwCKMDBXdLIUPQ30+iS3pZWp0PC
	T/56xRl81v5+WNq0BrQNzx+lrZToXSn0fU1wOr5zgMnw5SnQePy6eqQ33cqcUYeK5z0KMW
	27afWDEYLMugF1Dk/2ubNa7FuFU3jVE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-toVAdbV7NkupH4EZS3Am9w-1; Thu,
 13 Jun 2024 11:02:11 -0400
X-MC-Unique: toVAdbV7NkupH4EZS3Am9w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A268C1955BDF;
	Thu, 13 Jun 2024 15:01:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.233])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1E7D21955E72;
	Thu, 13 Jun 2024 15:01:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 13 Jun 2024 17:00:17 +0200 (CEST)
Date: Thu, 13 Jun 2024 17:00:02 +0200
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
Subject: Re: [PATCH] zap_pid_ns_processes: don't send SIGKILL to sub-threads
Message-ID: <20240613150001.GB18218@redhat.com>
References: <1386cd49-36d0-4a5c-85e9-bc42056a5a38@linux.microsoft.com>
 <20240608154835.GD7947@redhat.com>
 <87msnpov2z.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msnpov2z.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 06/13, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > The comment above the idr_for_each_entry_continue() loop tries to explain
> > why we have to signal each thread in the namespace, but it is outdated.
> > This code no longer uses kill_proc_info(), we have a target task so we can
> > check thread_group_leader() and avoid the unnecessary group_send_sig_info.
> > Better yet, we can change pid_task() to use PIDTYPE_TGID rather than _PID,
> > this way it returns NULL if this pid is not a group-leader pid.
> >
> > Also, change this code to check SIGNAL_GROUP_EXIT, the exiting process /
> > thread doesn't necessarily has a pending SIGKILL. Either way these checks
> > are racy without siglock, so the patch uses data_race() to shut up KCSAN.
>
> You remove the comment but the meat of what it was trying to say remains
> true.  For processes in a session or processes is a process group a list
> of all such processes is kept.  No such list is kept for a pid
> namespace.  So the best we can do is walk through the allocated pid
> numbers in the pid namespace.

OK, I'll recheck tomorrow. Yet I think it doesn't make sense to send
SIGKILL to sub-threads, and the comment looks misleading today. This was
the main motivation, but again, I'll recheck.

> It would also help if this explains that in the case of SIGKILL
> complete_signal always sets SIGNAL_GROUP_EXIT which makes that a good
> check to use to see if the process has been killed (with SIGKILL).

Well, if SIGNAL_GROUP_EXIT is set we do not care if this process was
killed or not. It (the whole thread group) is going to exit, that is all.

We can even remove this check, it is just the optimization, just like
the current fatal_signal_pending() check.

Oleg.

