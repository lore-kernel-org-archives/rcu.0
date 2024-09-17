Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0B151C5A
	for <rcu@vger.kernel.org>; Tue, 17 Sep 2024 06:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726554414; cv=none; b=krQXP2eH+xMkbRTCWqcGbHwIQMWqqw+gCfYqy3cGr5lzOqhEVUzdGZ21LB6vkTjG2hFjw9yqiWMaXDzYlzUifbN1ajjYEq0JCGVS5UbqGiLKnWfusAwiGMRJSlHk2oDtc28h7BZyHSL6H5T1aXTitSu7rnN40aEZs7LCsfoAfFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726554414; c=relaxed/simple;
	bh=K2nQcmcKXIirQ5jLWaunQvyy+nQEk3uCk9cCllOs3FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJm+PSMSlamcJwWSBLtEndYiKG6SI9CXQLo0z5x/1+yTWLRSoZjGYQb7xk7+vaxrHwr8j9xIKM7XGbEleLR5Ble6YincSkdxtqEZQhFUE5qKYK7P1pH5L2MePBEsweICy+dY+8CZDaCd8bM8Khdk3TaoLHgV9RMlLcYclBdQhrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GpTEfiC5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GpTEfiC5"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a90188ae58eso648130966b.1
        for <rcu@vger.kernel.org>; Mon, 16 Sep 2024 23:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726554411; x=1727159211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7ASPViLRBSV8sKUrdJL1Dpttwd/ZWizZrt8YYj/Fgs=;
        b=GpTEfiC5UPJGcA7CFLB0DfD0VRat3wUS/iaWh9aDjHmDh4jTuMrgZ5X7tPkb+4uo7f
         o+ne/3KrVZly86KSIBi1ivMtoD9Tv06a8JhkNSsmmoja0emnTQ//w9SIKsEQIs9NnNof
         UtKTu2EkyqkZjndIn0hbZcpkCa+inIWs7GLHj5Bdfb4eHtcw5XY4a9Ro1KAuldSc6YEj
         SBhWbECEy8aYNlao2CWKcLfpPD8/A2kW9n+TMxtEzTqeJNMTsvSfQx8mf7R9dadVZfCi
         d3WPSKWBzR1vD2grCDQfMoNJnlRkoNNf2w6zp5rpbC/iZx3iayqw2cS7SuLngvPz1Obl
         U8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726554411; x=1727159211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7ASPViLRBSV8sKUrdJL1Dpttwd/ZWizZrt8YYj/Fgs=;
        b=in47OO2HzkgVRwlSMCAXSK3p+TqVWE/sp+K0zQADqkWRdIeU4InUf+okBazsZM4+vq
         PYcWiFovuRSGjQQJTeCQ9iKIipieZyzewmQj0MeiGTHzYY3EBenOe9o8g07zCXj9Z3Ln
         OFJabn2CeKGO8lRMj7rNYtmr6e7uSD0UqJs/urCm7iFKgY6RBTH92vrfYSVd05SolBor
         dgWSK7YBdXr6gyjysorP+gXwYYuJj5UDk8IH11v3yyQ2cwUX/LUk7ShQyPqBGd7rYhLa
         guOv5SG1RqQHcmxKwgYSKcSss4qsE44xZcuPDLizLJzGkH3lsipGD/ALFlJLrrksuf3B
         LjsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX7WppY+boKBgCGcxrnwlBJ9JdfyS8frvVydXrznDHKcUIhaFOn4PQy8S1WEaJzwNX5KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFW2P6ZpNxA4PTCr3wKMvylKdKmqctsYuIkJmzmQz2lfOzNt6S
	jo2ybS5UHRr0FRgevFzmGYdmhMirhVJDJdCza45JZem/x6XIKJGLFULzGla+OZ0=
X-Google-Smtp-Source: AGHT+IFp61tQdL1aMBFJZPYLyvUg/ylcWPkrD82sQbDo/hxlsqMN67eL0E/fc3/5YTdEwjY1O+ahhQ==
X-Received: by 2002:a17:907:e283:b0:a8a:af0c:dba9 with SMTP id a640c23a62f3a-a9029444940mr1546939566b.16.1726554410677;
        Mon, 16 Sep 2024 23:26:50 -0700 (PDT)
Received: from localhost (109-81-84-13.rct.o2.cz. [109.81.84.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e5600sm408627266b.175.2024.09.16.23.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 23:26:50 -0700 (PDT)
Date: Tue, 17 Sep 2024 08:26:49 +0200
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 12/19] kthread: Default affine kthread to its preferred
 NUMA node
Message-ID: <ZukhKXxErPOaXtAL@tiehlicka>
References: <20240916224925.20540-1-frederic@kernel.org>
 <20240916224925.20540-13-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916224925.20540-13-frederic@kernel.org>

On Tue 17-09-24 00:49:16, Frederic Weisbecker wrote:
> Kthreads attached to a preferred NUMA node for their task structure
> allocation can also be assumed to run preferrably within that same node.
> 
> A more precise affinity is usually notified by calling
> kthread_create_on_cpu() or kthread_bind[_mask]() before the first wakeup.
> 
> For the others, a default affinity to the node is desired and sometimes
> implemented with more or less success when it comes to deal with hotplug
> events and nohz_full / CPU Isolation interactions:
> 
> - kcompactd is affine to its node and handles hotplug but not CPU Isolation
> - kswapd is affine to its node and ignores hotplug and CPU Isolation
> - A bunch of drivers create their kthreads on a specific node and
>   don't take care about affining further.
> 
> Handle that default node affinity preference at the generic level
> instead, provided a kthread is created on an actual node and doesn't
> apply any specific affinity such as a given CPU or a custom cpumask to
> bind to before its first wake-up.

Makes sense.

> This generic handling is aware of CPU hotplug events and CPU isolation
> such that:
> 
> * When a housekeeping CPU goes up and is part of the node of a given
>   kthread, it is added to its applied affinity set (and
>   possibly the default last resort online housekeeping set is removed
>   from the set).
> 
> * When a housekeeping CPU goes down while it was part of the node of a
>   kthread, it is removed from the kthread's applied
>   affinity. The last resort is to affine the kthread to all online
>   housekeeping CPUs.

But I am not really sure about this part. Sure it makes sense to set the
affinity to exclude isolated CPUs but why do we care about hotplug
events at all. Let's say we offline all cpus from a given node (or
that all but isolated cpus are offline - is this even
realistic/reasonable usecase?). Wouldn't scheduler ignore the kthread's
affinity in such a case? In other words how is that different from
tasksetting an userspace task to a cpu that goes offline? We still do
allow such a task to run, right? We just do not care about affinity
anymore.
-- 
Michal Hocko
SUSE Labs
