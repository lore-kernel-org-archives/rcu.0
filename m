Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6041B5808;
	Tue, 30 Jul 2024 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354497; cv=none; b=If3u6NSJ6HdPr2VcotJHEIe4dgH2UxGxmWpQGEnLAxC/3URfZOjYzPuTW99aSPjuYbte8c7KcI2WJ6eUVk8lw1h5o4vVxPNYS3+3Q07dw6YQHPvUQkJTFYwpwwxHvBLki+jY7UZsuqDZkV3lR1dN/FanpZ2Y8bkHVycLB0ItnrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354497; c=relaxed/simple;
	bh=A1eJMp6z+3xGS8Oooe/jyVYnb7SvXE51NYcYEgjjnB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3z+G4Xd+YgA8/ye0VXkiAdscPhocs8AlHBDzLRDD728Oa8ps7xo37oQ8LaORPD4XEVVW/clVc9L9rDhPaQbZ0kpo126jlnh+vNRAA+2EAoN0pdmadeiqzev1ljfPKVSnXevdKmSg+t2NwpqJF6JBMTT+yh3lRpZShpepu9fvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ek+2tm02; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lPdsf4c9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ek+2tm02; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lPdsf4c9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ek+2tm02";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lPdsf4c9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ek+2tm02";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lPdsf4c9"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 85A061F7FA;
	Tue, 30 Jul 2024 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722354493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/S5tZTRn63vnVTPwzlEfrWM8nM+yXiZ15+Qp4xtJ34=;
	b=ek+2tm02tfDRhj7qSjMS/hNdyTwZD3hd8uguRB4P5ebxE1D1c9ZfOXNiz1wiPLDcuoeCtr
	YT4rzh3LUwltP9qQWU9aq63+UYSKraziAEo0oNMIjjwB2bKZ4YG97XOhXqe+fiSBeLlrsx
	fKTrwEQSC8IjFivBGtxusQuaE5dRALY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722354493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/S5tZTRn63vnVTPwzlEfrWM8nM+yXiZ15+Qp4xtJ34=;
	b=lPdsf4c97WqbwCeYlrR4EV0NKnMpn3MpmL+MqE7ZnJYnaxbYGLnY/1eyUqw0UASqcIJ1BO
	Sw2+28i/twA9aaAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722354493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/S5tZTRn63vnVTPwzlEfrWM8nM+yXiZ15+Qp4xtJ34=;
	b=ek+2tm02tfDRhj7qSjMS/hNdyTwZD3hd8uguRB4P5ebxE1D1c9ZfOXNiz1wiPLDcuoeCtr
	YT4rzh3LUwltP9qQWU9aq63+UYSKraziAEo0oNMIjjwB2bKZ4YG97XOhXqe+fiSBeLlrsx
	fKTrwEQSC8IjFivBGtxusQuaE5dRALY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722354493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/S5tZTRn63vnVTPwzlEfrWM8nM+yXiZ15+Qp4xtJ34=;
	b=lPdsf4c97WqbwCeYlrR4EV0NKnMpn3MpmL+MqE7ZnJYnaxbYGLnY/1eyUqw0UASqcIJ1BO
	Sw2+28i/twA9aaAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FCC013983;
	Tue, 30 Jul 2024 15:48:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 02gBGz0LqWZXBgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 30 Jul 2024 15:48:13 +0000
Message-ID: <4e9d1f6d-9cd8-493c-9440-b46a99f1c8af@suse.cz>
Date: Tue, 30 Jul 2024 17:49:51 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/20] kthread: Implement preferred affinity
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
 <20240726215701.19459-13-frederic@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20240726215701.19459-13-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.41 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,infradead.org,linutronix.de,kvack.org,joelfernandes.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: 0.41

On 7/26/24 11:56 PM, Frederic Weisbecker wrote:
> Affining kthreads follow either of three existing different patterns:
> 
> 1) Per-CPU kthreads must stay affine to a single CPU and never execute
>    relevant code on any other CPU. This is currently handled by smpboot
>    code which takes care of CPU-hotplug operations.
> 
> 2) Kthreads that _have_ to be affine to a specific set of CPUs and can't
>    run anywhere else. The affinity is set through kthread_bind_mask()
>    and the subsystem takes care by itself to handle CPU-hotplug operations.
> 
> 3) Kthreads that have a _preferred_ affinity but that can run anywhere
>    without breaking correctness. Userspace can overwrite the affinity.
>    It is set manually like any other task and CPU-hotplug is supposed
>    to be handled by the relevant subsystem so that the task is properly
>    reaffined whenever a given CPU from the preferred affinity comes up
>    or down. Also care must be taken so that the preferred affinity
>    doesn't cross housekeeping cpumask boundaries.
> 
> Currently the preferred affinity pattern has at least 4 identified
> users, with more or less success when it comes to handle CPU-hotplug
> operations and housekeeping cpumask.
> 
> Provide an infrastructure to handle this usecase patter. A new
> kthread_affine_preferred() API is introduced, to be used just like
> kthread_bind_mask(), right after kthread creation and before the first
> wake up. The kthread is then affine right away to the cpumask passed
> through the API if it has online housekeeping CPUs. Otherwise it will
> be affine to all online housekeeping CPUs as a last resort.
> 
> It is aware of CPU hotplug events such that:
> 
> * When a housekeeping CPU goes up and is part of the preferred affinity
>   of a given kthread, it is added to its applied affinity set (and
>   possibly the default last resort online housekeeping set is removed
>   from the set).
> 
> * When a housekeeping CPU goes down while it was part of the preferred
>   affinity of a kthread, it is removed from the kthread's applied
>   affinity. The last resort is to affine the kthread to all online
>   housekeeping CPUs.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nit:

> +int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask)
> +{
> +	struct kthread *kthread = to_kthread(p);
> +	cpumask_var_t affinity;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!wait_task_inactive(p, TASK_UNINTERRUPTIBLE) || kthread->started) {
> +		WARN_ON(1);
> +		return -EINVAL;
> +	}
> +

Should we also fail if kthread->preferred_affinity already exist? In
case somebody calls this twice.

Also for some of the use cases (kswapd, kcompactd) it would make sense
to be able to add cpus of a node as they are onlined. Which seems we
didn't do, except some corner case handling in kcompactd, but maybe we
should? I wonder if the current implementation of onlining a completely
new node with cpus does the right thing as a result of the individual
onlining operations, or we end up with being affined to a single cpu (or
none).

But that would need some kind of kthread_affine_preferred_update()
implementation?

> +	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	kthread->preferred_affinity = kzalloc(sizeof(struct cpumask), GFP_KERNEL);
> +	if (!kthread->preferred_affinity) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	mutex_lock(&kthreads_hotplug_lock);
> +	cpumask_copy(kthread->preferred_affinity, mask);
> +	list_add_tail(&kthread->hotplug_node, &kthreads_hotplug);
> +	kthread_fetch_affinity(kthread, affinity);
> +
> +	/* It's safe because the task is inactive. */
> +	raw_spin_lock_irqsave(&p->pi_lock, flags);
> +	do_set_cpus_allowed(p, mask);
> +	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> +
> +	mutex_unlock(&kthreads_hotplug_lock);
> +out:
> +	free_cpumask_var(affinity);
> +
> +	return 0;
> +}
> +
> +static int kthreads_hotplug_update(void)
> +{
> +	cpumask_var_t affinity;
> +	struct kthread *k;
> +	int err = 0;
> +
> +	if (list_empty(&kthreads_hotplug))
> +		return 0;
> +
> +	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	list_for_each_entry(k, &kthreads_hotplug, hotplug_node) {
> +		if (WARN_ON_ONCE(!k->preferred_affinity)) {
> +			err = -EINVAL;
> +			break;
> +		}
> +		kthread_fetch_affinity(k, affinity);
> +		set_cpus_allowed_ptr(k->task, affinity);
> +	}
> +
> +	free_cpumask_var(affinity);
> +
> +	return err;
> +}
> +
> +static int kthreads_offline_cpu(unsigned int cpu)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&kthreads_hotplug_lock);
> +	cpumask_clear_cpu(cpu, &kthread_online_mask);
> +	ret = kthreads_hotplug_update();
> +	mutex_unlock(&kthreads_hotplug_lock);
> +
> +	return ret;
> +}
> +
> +static int kthreads_online_cpu(unsigned int cpu)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&kthreads_hotplug_lock);
> +	cpumask_set_cpu(cpu, &kthread_online_mask);
> +	ret = kthreads_hotplug_update();
> +	mutex_unlock(&kthreads_hotplug_lock);
> +
> +	return ret;
> +}
> +
> +static int kthreads_init(void)
> +{
> +	return cpuhp_setup_state(CPUHP_AP_KTHREADS_ONLINE, "kthreads:online",
> +				kthreads_online_cpu, kthreads_offline_cpu);
> +}
> +early_initcall(kthreads_init);
> +
>  void __kthread_init_worker(struct kthread_worker *worker,
>  				const char *name,
>  				struct lock_class_key *key)
