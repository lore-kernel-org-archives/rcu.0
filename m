Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E757417BE9
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021580; cv=none; b=ZVpRHcoP46djAFZpSOOhX+7tIKeegtUiAHrvNNdBS0HLJh5rrhs6eHqIoak7im+hvh7dZCJupUcqqyllzRQoOcialwQ7n+l9PeQ73JZ7rBewc5GjR5Lvh4ZbDWcZvz7R9Pao/jz10yYfBmRi2JuqYDHtNz3V0rZj5R6oxgxMxr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021580; c=relaxed/simple;
	bh=w6yJUW/RNzqEWgUPynuPUDsNWhvDhUuH0mK5X7pIDs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFNKQHFyZW1WnpKPh37lvsUNSaSjmEsy9a4DmHm930WTrUSZndlFWLPcxI1h8Q20XpRrw15wo0X2OjfY9ToRk+g0m+wUaGbWBvaogfu4Th3xbZD7BPwENMii9JYMX+3PztNpFrB51brN+SaZ6hyslUO+ydjKezqA5yWh6CRjMkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5CfB2c+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5CfB2c+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790021578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6chaT+lC13U/LIehoKCT6qfQE0dkbiIKm2cvcaiwV9I=;
	b=d5CfB2c+/zEubhj/kicym3m+6otTttMonFoMYsrvvf5zqA3RLrTUqd3O5KvEzIT2p2Cyrs
	saVqRqtzzuWU5liw6GlCudktQJmfqKFpMykhfqYteYBNOmtwd4aT+DZ+9ZGXN5TzQHXKNY
	uut/gB/Zx1Yppr6PB4lUpjNOHdFMXNM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-AS_6cO67OZy8F3Vz2U-O_g-1; Mon,
 21 Sep 2026 16:12:52 -0400
X-MC-Unique: AS_6cO67OZy8F3Vz2U-O_g-1
X-Mimecast-MFC-AGG-ID: AS_6cO67OZy8F3Vz2U-O_g_1790021571
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 689551955F79;
	Mon, 21 Sep 2026 20:12:50 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BCA221956042;
	Mon, 21 Sep 2026 20:12:33 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 21 Sep 2026 22:12:50 +0200 (CEST)
Date: Mon, 21 Sep 2026 22:12:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes <ljs@kernel.org>,
	Gregory Price <gourry@gourry.net>, SJ Park <sj@kernel.org>,
	peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com,
	rostedt@goodmis.org, jpoimboe@kernel.org, mic@digikod.net,
	tglx@kernel.org, david@kernel.org, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, rafael@kernel.org, gnoack3000@gmail.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, rientjes@google.com,
	shakeel.butt@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	pavel@kernel.org, lance.yang@linux.dev, mhiramat@kernel.org,
	pmladek@suse.com, longman@redhat.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, dietmar.eggemann@arm.com, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com,
	babu.moger@amd.com
Subject: Re: [PATCH v4 14/15] lib: convert process iterator to
 for_each_process_rculock
Message-ID: <arGPsIWUJXVshwqY@redhat.com>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921093311.104814-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921093311.104814-1-ye.liu@linux.dev>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/21, Ye Liu wrote:
>
> diff --git a/lib/is_single_threaded.c b/lib/is_single_threaded.c
> index 8c98b20bfc41..4e7fe85454ab 100644
> --- a/lib/is_single_threaded.c
> +++ b/lib/is_single_threaded.c
> @@ -26,8 +26,7 @@ bool current_is_single_threaded(void)
>  		return true;
>
>  	ret = false;
> -	rcu_read_lock();
> -	for_each_process(p) {
> +	for_each_process_rculock(p) {
>  		if (unlikely(p->flags & PF_KTHREAD))
>  			continue;
>  		if (unlikely(p == task->group_leader))
> @@ -48,7 +47,5 @@ bool current_is_single_threaded(void)
>  	}
>  	ret = true;
>  found:
> -	rcu_read_unlock();
> -

Reviewed-by: Oleg Nesterov <oleg@redhat.com>



but I think that the "found" label and "int ret" can now be removed,
the for_each_thread() loop can just do

	...
	if (unlikely(t->mm == mm))
		return false;

and current_is_single_threaded() can simply return true after
the main for_each_process_rculock() loop.

But again, I agree with this patch, it looks simple and "obviously correct".
Even if I am right, the simplifications above need a separate change.

Oleg.

