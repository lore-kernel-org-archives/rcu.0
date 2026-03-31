Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BC43FBEB2
	for <rcu@vger.kernel.org>; Tue, 31 Mar 2026 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967919; cv=none; b=XKmD2OMzbJA3mh/TSrWqf0BWt3ayr9csry4h81NbqR9vAKD9mKBwvxxr1dqCP7a+utUw/tY0eZsKfX8OIM53vCniq9th9jjNlx+J60VDzd0fgB3wTiKeJtn1G5DIoMkwtzbaAhmdMtD7AvEgnWCYs+6FzoQ5uOoEQeIeILXjirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967919; c=relaxed/simple;
	bh=XPgKCAQXXpgypZ8fa7/mk1K1DLkFu5crzaxLGv5rCmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPMK0sHsl2Mt64SSZSuhE+6FtvejbnqW9ZMf3vhljWQ4KZ6HM1AjGI74utkUVTTA9VWDoIjUJGEXVqbeJQ4zlWX9ClvZ21AgW4JCStJnRs6DsjNSp8O4B8038fnsnICzwyYXHFY/q7AbGqaDVZTsK0j8DakTk7mtVprfFyluMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wv1cbtad; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wv1cbtad"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774967916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHBK5RTcHGLUApVZiHj/Q/LEldgau7IiSnUjcS1LBic=;
	b=Wv1cbtad7x3HjFQzQcrGo7knI/9yeJyuQ8dFMCCXXnxNnYEW3H7fTqfD4qvMiuh6FyTGQZ
	M0mPzYLRa5j3Gdz7K15rN4wbmoWfI4t27iqXbqGgNWoMZX0tbSIPQAZflIzhApe59S9Yk/
	8DduwNt9rM1kv8VABt8EzdQv8ImZS84=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-eVd53RCqMKiPhEyAHC9y8g-1; Tue,
 31 Mar 2026 10:38:33 -0400
X-MC-Unique: eVd53RCqMKiPhEyAHC9y8g-1
X-Mimecast-MFC-AGG-ID: eVd53RCqMKiPhEyAHC9y8g_1774967909
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14F8F1956065;
	Tue, 31 Mar 2026 14:38:28 +0000 (UTC)
Received: from [10.22.80.26] (unknown [10.22.80.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1756030001A2;
	Tue, 31 Mar 2026 14:38:20 +0000 (UTC)
Message-ID: <f24641b7-a177-467c-9554-e2ff188ca23e@redhat.com>
Date: Tue, 31 Mar 2026 10:38:20 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] sched/isolation: Implement sysfs interface for
 dynamic housekeeping
To: Qiliang Yuan <realwujing@gmail.com>, peterz@infradead.org
Cc: cgroups@vger.kernel.org, akpm@linux-foundation.org,
 anna-maria@linutronix.de, boqun.feng@gmail.com, bsegall@google.com,
 dietmar.eggemann@arm.com, frederic@kernel.org, hannes@cmpxchg.org,
 jackmanb@google.com, jiangshanlai@gmail.com, joelagnelf@nvidia.com,
 josh@joshtriplett.org, juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 mathieu.desnoyers@efficios.com, mgorman@suse.de, mhocko@suse.com,
 mingo@kernel.org, mingo@redhat.com, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rostedt@goodmis.org, shuah@kernel.org, surenb@google.com, tglx@kernel.org,
 tj@kernel.org, urezki@gmail.com, vbabka@suse.cz, vincent.guittot@linaro.org,
 vschneid@redhat.com, ziy@nvidia.com
References: <20260325140432.GE3738786@noisy.programming.kicks-ass.net>
 <20260330114620.104027-1-realwujing@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260330114620.104027-1-realwujing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


On 3/30/26 7:46 AM, Qiliang Yuan wrote:
> On Wed, Mar 25, 2026 at 03:04:32PM +0100, Peter Zijlstra wrote:
>> Why? What was wrong with cpusets?
> This is the central point of the architecture. The distinction I was
> trying to address is:
>
> 1. Task Isolation (Current CPUSets):
>     The `cpuset` subsystem (especially `cpuset.cpus.partition = isolated`)
>     is excellent at managing task placement and load balancing. It
>     ensures no user tasks are pushed to isolated CPUs.
>
> 2. Kernel Overhead Isolation (Housekeeping):
>     Currently, `cpusets` do not manage kernel-internal overhead like RCU
>     callbacks, timers, or unbound workqueues. These are managed by the
>     global `housekeeping_cpumask`, which is settled at boot via
>     `isolcpus`/`nohz_full` and is static.

My plan is to extend the cpuset isolated partition mechanism to isolate 
other kernel noise currently covered by the nohz_full and manged_irq 
boot command line. That will makes the HK_TYPE_KERNEL_NOISE cpumask 
modifiable at run time. It is not a direct modification of the HK 
cpumasks as advocated by this patch series but an indirect one via the 
creation of the appropriate isolated cpuset partitions.

Cheers,
Longman

