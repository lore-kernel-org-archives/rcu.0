Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A5D521217
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788803860; cv=none; b=bQ7IzjatjouOFAvHccQPkiY2eOHHEqiD/1N0cooUM1Nv5XpufUc6fjkTV2qnp+W9YD5G/amOXzbGhihVztpEcCH3O8dHpLq5kTlob5/VvqQrxhhajvNzwCikGtPAS6VyMsSWPdaw0iz4iVkOiwzXBmWJwikLW2LDYneN8KVvSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788803860; c=relaxed/simple;
	bh=7j1GuZlr4DkZd3tFGTmsdUmo9C7PnISCitw4kPz9VIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWvYCYgMXnrWGkuvJCwCocYi8KMb4OF37IXVVinjFmJtzusMme2HDvlVmCVD3ewm/lF+G526uvm+yao42IWxuP8lJwAaAmpyYYXVfBhlOswkjPUAN54LH0iC29O0oBIIEu4nyG73igK0ZCpTiv1b84krROI09ArkYJ1CSeuILJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bklFb8/E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bklFb8/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788803855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBB+Ha5hfEwnTM3XMtEUMJZL5woFR7RP7WxRg6VNgHk=;
	b=bklFb8/EvP1uzvxOrXFhiGw/Tok/euVXiL+HN3bzYt1tLY9MWXx5ZXtc/pFjLU+4G+izaH
	lCIJcxAoT1jck0QEofMHCtHKMfi6VFOTR42o0VnFuDOMNv64ru+gtQGqoaqgMJmpI9REDS
	Z26Wp6hm/teQYDCZUbbgyd8R9j5899M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-LOu-IESzNa-TentWVwO3qQ-1; Mon,
 07 Sep 2026 13:57:34 -0400
X-MC-Unique: LOu-IESzNa-TentWVwO3qQ-1
X-Mimecast-MFC-AGG-ID: LOu-IESzNa-TentWVwO3qQ_1788803853
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC8E71954B12;
	Mon,  7 Sep 2026 17:57:32 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 779F3180059E;
	Mon,  7 Sep 2026 17:57:16 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  7 Sep 2026 19:57:32 +0200 (CEST)
Date: Mon, 7 Sep 2026 19:57:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Gregory Price <gourry@gourry.net>
Cc: Ye Liu <ye.liu@linux.dev>, Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>, mic@digikod.net, david@kernel.org,
	linmiaohe@huawei.com, nao.horiguchi@gmail.com, gnoack3000@gmail.com,
	ljs@kernel.org, sj@kernel.org, rientjes@google.com,
	shakeel.butt@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, tony.luck@intel.com,
	reinette.chatre@intel.com, x86@kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, pavel@kernel.org,
	lance.yang@linux.dev, pmladek@suse.com, longman@redhat.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, dietmar.eggemann@arm.com, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com,
	babu.moger@amd.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 5/8] kernel: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <ap76-0-hN6CAcYXX@redhat.com>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-6-ye.liu@linux.dev>
 <ap7dC-LWNaoPYJvv@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap7dC-LWNaoPYJvv@gourry-fedora-PF4VCD3F>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/07, Gregory Price wrote:
>
> On Mon, Sep 07, 2026 at 04:13:31PM +0800, Ye Liu wrote:
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -315,13 +315,12 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
> >  		return;
> >
> >  	this_round_count = 0;
> > -	rcu_read_lock();
> > -	for_each_process_thread(g, t) {
> > +	for_each_process_thread_rculock(g, t) {
> >  		if (!max_count--)
> > -			goto unlock;
> > +			goto out;
> ... snip ...
> > - unlock:
> > -	rcu_read_unlock();
> > -
> > +out:
> >  	if (!this_round_count)
> >  		return;
> >
>
> The sunken rcu_read_lock()/unlock() + scoped_guard usage makes this goto
> at a minimum very confusing, if not actually broken.

I am afraid I misunderstood you concerns...

This patch renames the "unlock:" label to "out:", and to me this makes sense.

Unfortunately for_each_process_thread() and the new helper can't use "break".

Oleg.

