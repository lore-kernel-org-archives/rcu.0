Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614629A2;
	Tue, 30 Jul 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352715; cv=none; b=SfXd4l9FYOMc/J/+eHXEfcKUK93OF5b/+TrvYt3F+dCRKCB2OhkVaFlRMLYhg9hjTimO2DNyQ5O8irdcn/cRatSuhI/dclLX8xsuD8U4tHOYIQ/J7vs3AEDGNVcDZvDV07PNM6pRnFaULPHq2f/1NZdofixINaXvI7MIPsrXKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352715; c=relaxed/simple;
	bh=eNLcA7zSXCe8eGEIGM92EQ1HzdaOkMHWmwqNFSsQaFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpLgGLWUpVcacxhTpJNkjYXi0HDBNyxs+uh/PiAsgghzX8HnNwNIOqzIa9XyHtMdh7cJbv/J1SjSwkmYspOEKWJdEeVH+ij88pIk0dr6SAbW+6A1P1glG0RvEc3MDUixKSZCHC1LLMSMTXNYOyH5ZEpOWKJPPTQS3d37/ERzUEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X8pDdYGR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5IhyBajd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OAahq62D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+JzXWHb6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X8pDdYGR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5IhyBajd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OAahq62D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+JzXWHb6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 875331F80F;
	Tue, 30 Jul 2024 15:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722352711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFJe/5/G1p03fX9svK0QGYtK67e42X0x0vZlF3sKQmE=;
	b=X8pDdYGRZKJJiSnTBMQ2aRjc5h1nKbZXnPDW6l+89Rviffkm2EW9kSIsapRvQCdrxJrdHj
	sk3Z5kvJfnESn+rDgK+crd4SzAa0XXybxhWT40kQ+H7Y6G6+c9UdZ6xQpGJm6CsQQL//fN
	U5cXrvvBz/galQRit3rsSgWjBoSeAok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722352711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFJe/5/G1p03fX9svK0QGYtK67e42X0x0vZlF3sKQmE=;
	b=5IhyBajdg+yj97Z43Gq0+F05kxDRzacE7qcJlTkMiCn68PO1U2rKXYHDY3wOsKuEsUQ8uU
	mWrcsKC1IhdADqDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722352710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFJe/5/G1p03fX9svK0QGYtK67e42X0x0vZlF3sKQmE=;
	b=OAahq62Dd6dpqibjbseuq9Q9OS4Fzgz2TN4s9OSAyyPALLipJgas85S6MXqg4w+PUTSG3e
	99PyuggbEwGoahbGijWdGFZ58SUnYLvmhWbzMx7E9FNBOhy+GAmuzIYTQ9zcJ6V6yhi1tF
	V2FNrKhKBbSpm1hEIP11SIVvIlNnqeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722352710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFJe/5/G1p03fX9svK0QGYtK67e42X0x0vZlF3sKQmE=;
	b=+JzXWHb64Snsq5UIjtYgdRZjFd7lqRAG3jTSlDT+8ZMkcXw8ALW/T00iz6v0bR08ehc2I9
	8ccLGiIEhDhDEwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7275113983;
	Tue, 30 Jul 2024 15:18:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g1GqG0YEqWYsfAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 30 Jul 2024 15:18:30 +0000
Message-ID: <f977c691-4d51-4b23-90b1-8ebcd1f36d73@suse.cz>
Date: Tue, 30 Jul 2024 17:20:12 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/20] kthread: Make sure kthread hasn't started while
 binding it
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>, Boqun Feng <boqun.feng@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
References: <20240726215701.19459-1-frederic@kernel.org>
 <20240726215701.19459-12-frederic@kernel.org>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240726215701.19459-12-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.59 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,infradead.org,linutronix.de,kvack.org,joelfernandes.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.59

On 7/26/24 11:56 PM, Frederic Weisbecker wrote:
> Make sure the kthread is sleeping in the schedule_preempt_disabled()
> call before calling its handler when kthread_bind[_mask]() is called
> on it. This provides a sanity check verifying that the task is not
> randomly blocked later at some point within its function handler, in
> which case it could be just concurrently awaken, leaving the call to
> do_set_cpus_allowed() without any effect until the next voluntary sleep.
> 
> Rely on the wake-up ordering to ensure that the newly introduced "started"
> field returns the expected value:
> 
>     TASK A                                   TASK B
>     ------                                   ------
> READ kthread->started
> wake_up_process(B)
>    rq_lock()
>    ...
>    rq_unlock() // RELEASE
>                                            schedule()
>                                               rq_lock() // ACQUIRE
>                                               // schedule task B
>                                               rq_unlock()
>                                               WRITE kthread->started
> 
> Similarly, writing kthread->started before subsequent voluntary sleeps
> will be visible after calling wait_task_inactive() in
> __kthread_bind_mask(), reporting potential misuse of the API.
> 
> Upcoming patches will make further use of this facility.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  kernel/kthread.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index f7be976ff88a..ecb719f54f7a 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -53,6 +53,7 @@ struct kthread_create_info
>  struct kthread {
>  	unsigned long flags;
>  	unsigned int cpu;
> +	int started;
>  	int result;
>  	int (*threadfn)(void *);
>  	void *data;
> @@ -382,6 +383,8 @@ static int kthread(void *_create)
>  	schedule_preempt_disabled();
>  	preempt_enable();
>  
> +	self->started = 1;
> +
>  	ret = -EINTR;
>  	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {
>  		cgroup_kthread_ready();
> @@ -540,7 +543,9 @@ static void __kthread_bind(struct task_struct *p, unsigned int cpu, unsigned int
>  
>  void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
>  {
> +	struct kthread *kthread = to_kthread(p);
>  	__kthread_bind_mask(p, mask, TASK_UNINTERRUPTIBLE);
> +	WARN_ON_ONCE(kthread->started);
>  }
>  
>  /**
> @@ -554,7 +559,9 @@ void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
>   */
>  void kthread_bind(struct task_struct *p, unsigned int cpu)
>  {
> +	struct kthread *kthread = to_kthread(p);
>  	__kthread_bind(p, cpu, TASK_UNINTERRUPTIBLE);
> +	WARN_ON_ONCE(kthread->started);
>  }
>  EXPORT_SYMBOL(kthread_bind);
>  
