Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3836026A;
	Fri, 26 Jul 2024 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722033097; cv=none; b=RaraMPl016hqKaIG3axvZFz1/ip1+b3k6zTnt/AOEHtQvyhskAMjPuN7eoCkKk0uY4733lhLd9VKDh+wMGNvDXvGskJTIhiYyeaPCirg8uZrQbPb7d3AOPk2K9OmAUwShQBo1z6cCtTNNydV74cL618od64gxmtO9KMy1jnpdqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722033097; c=relaxed/simple;
	bh=Vha1o4cDySp/3HxxP0IeuG98E1wJh5iHmPPpiVxnzX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7dh3EVLb0kVDRyJ4GrWlLi/6B4ErpJWoYCA8ofPVMqUYYixRZD8x821LiU+0oOG0KuZm6MoFHJOFIqX/wDiacWApAzMZF5uHyOcSgHk8XaeehBYIyJqgA2Y10dIy4s1EGpcWqvGrP69m7j1A08GnQAq/4qPCZHSzBhpsrZ4Xsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IljJvsS2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IljJvsS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E3CC32782;
	Fri, 26 Jul 2024 22:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722033097;
	bh=Vha1o4cDySp/3HxxP0IeuG98E1wJh5iHmPPpiVxnzX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IljJvsS24AoY00TO7h9ULsDeM+lE6rFBtwcOWlVUjE2nOYUwM5qRnBEo/55M52EAp
	 Zks+L5/EoB63Xbv9Qs0SxjflK7evV+SBoIrE5EV1AwSzQqgIowZ840XrUFPJU/BsrG
	 7ZtOyD/kHWb//n1cSl9mSyPTrJgItJsheudGbN/JIJV5LiO4ZS4Ai7J46axicovKZ5
	 NV42pxwm5Kpvj7coc6HRZVO6xnD1U+0oixersK7QT/8NROmH75CIPM0H4WVVukFVK2
	 sU89nkp2ZVfCLDGtGRryhQ6zsf+MgFeiAOrl3Q4R3h+Sh28aOvCB550gVl1Z4fB2Qp
	 zKJMjKrbq5Y0w==
Date: Sat, 27 Jul 2024 00:31:34 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [RFC PATCH 12/20] kthread: Implement preferred affinity
Message-ID: <ZqQjxnWWKYBIpueP@pavilion.home>
References: <20240726215701.19459-1-frederic@kernel.org>
 <20240726215701.19459-13-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240726215701.19459-13-frederic@kernel.org>

Le Fri, Jul 26, 2024 at 11:56:48PM +0200, Frederic Weisbecker a écrit :
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

s/mask/affinity
