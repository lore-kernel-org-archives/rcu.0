Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2C747D442;
	Fri, 11 Sep 2026 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131538; cv=none; b=QHkwKFyODE3AHhXQ4j0iQx8QqjCQkz1EE+EHwylI3G++rZOfd8sGpirPMPaja5a9onL9dU5CYO1NA4adIfWge5BZMZm2IfFjYeh8qqmB2OLT/UHQi7JISYTX0PzstGUWErNRJX1+LKwTq0CHFoc3U6Q+J3bV71sHl33uGAXRqPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131538; c=relaxed/simple;
	bh=bjoTTqpWpKvplAqU+RyCcsF1m/WtPEW3tfKywXliCM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8yaJNx4Z0Kn+7xf7QCDEANgT7Qp9d4dKtLtneBVPLDLFHB8Tub4xRmTh9RUS4JKQUGtIlXVwWakKsbK8juslUY5SS2yCvABdAUPzpcOXCBXQ6aS6UnQr/SnZOQv1LTGenpA5sczC+xBRmiylpK2w5EfX5xfOdzeoVOR1RWqdE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=0JqVOVv+; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="0JqVOVv+"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 57FF11A0226;
	Fri, 11 Sep 2026 12:58:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 411FB80012;
	Fri, 11 Sep 2026 12:57:57 +0000 (UTC)
Date: Fri, 11 Sep 2026 08:59:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ye Liu <liuye@kylinos.cn>,
 Michal Hocko <mhocko@suse.com>, SJ Park <sj@kernel.org>, Lorenzo Stoakes
 <ljs@kernel.org>, Oleg Nesterov <oleg@redhat.com>, peterz@infradead.org,
 paulmck@kernel.org, mingo@redhat.com, jpoimboe@kernel.org, mic@digikod.net,
 tglx@kernel.org, akpm@linux-foundation.org, david@kernel.org,
 linmiaohe@huawei.com, nao.horiguchi@gmail.com, rafael@kernel.org,
 gnoack3000@gmail.com, gourry@gourry.net, rientjes@google.com,
 shakeel.butt@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev,
 will@kernel.org, boqun@kernel.org, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org,
 urezki@gmail.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org,
 lance.yang@linux.dev, pmladek@suse.com, longman@redhat.com,
 mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
 mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com,
 babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rcu@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 11/15] tracing/fgraph: convert process/thread
 iterator to for_each_process_thread_rculock
Message-ID: <20260911085918.30c87ab3@gandalf.local.home>
In-Reply-To: <20260911075800.491472-12-ye.liu@linux.dev>
References: <20260911075800.491472-1-ye.liu@linux.dev>
	<20260911075800.491472-12-ye.liu@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 411FB80012
X-Stat-Signature: n6a6yg87erzr1tr8kadm4kbym8uws4c7
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX184cgL4CPzpG6wyU7gqy6pHH3IT2rF9ets=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=UaQYdknTmueyDeiPHskDcTArMbJldar1uQP+OR5ILiM=; b=0JqVOVv+9L81lkGml08i9mMS8B782yjgSSh0J7qB8NJfLJbXU0fLz9weZAM4fQ5Ra9CUavRTBo+PCH73WKm//G+wNOzwNoyxnF2a7JXOtbmdL7tZR3SzwRbbk7iw2rNQVN3kwRcItAAPl3JNid1xBW4naEquTGk2Qi05wOwcUrA=
X-HE-Tag: 1789131477-955751
X-HE-Meta: U2FsdGVkX18IEJ34TJ0+KfkZrrzHJ2dGti8SCtUwJBxnBs7A77nAwjwyHWgBGGkRmcWxfRbbgYYDx9+//1mp9vVOjUQbCfr8JwoUfq6qObLo5XckYsaDveVKT4KVuSxa43lMppAHrfkQ6q66hua38QSWiGZ4pR4WLuiB/fRlv95rgRSwCTUef6/9xZIREFm6zARLWSxhMwm/+USXJ5Odeo33wnQhHtMWXVBSR1fuAOuRDXqRFn/VmuEmY4R93qX7JzsgtbqMZNWtX+CwTgbkKXii7THG1FmHcDAGAFH4eWA8QubRpp9x6o0Bf0fFFGOxvfWU4KGfGsEN23tdH4CEfp8DdKmJ89MyETXiouFLfhLA9mjoesG1uJ4spkJ5GIdarVsiaR7bvBIJXGMAkAiEBCCCpjOlciuLokm1pcCBCZvkrE1QZjTT39frBEzytesHCZdU724fPrc5uye0+xI5ILZJA4Ngv6OQ1x3Efp0PWJo=

On Fri, 11 Sep 2026 15:57:56 +0800
Ye Liu <ye.liu@linux.dev> wrote:

> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process_thread() loop in kernel/trace/fgraph.c with
> for_each_process_thread_rculock(), which scopes the RCU read lock
> to the loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
