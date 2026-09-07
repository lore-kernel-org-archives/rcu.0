Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049343F12CA
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821083; cv=none; b=TxFxRhRQxU6k/kT9Rf8WdNyZUEUyhNHRtzOvumyeJEw2XzHdr1BQRH7YbDTjG3AiGDlAFZjnaYg0j6cdrGnx3thIrCnCfIEXAyyV7NS5//lCXkh18dPPLjuOtXXFF0WWr+T1ya+KMSweTkfriYuuEYmkCjNr01lvaOJIXRYycQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821083; c=relaxed/simple;
	bh=J8kU2kAxNOmmnwSc84F95Ok5dyfh/t/PEHhe+MDnpN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPnD7vn/rKXr1kdshifEAAHyflilnEaHdU4x6O0UVzb3yh4tvPlPdWzPxSANcy8ExozwKAfJUlQ3jS88x5hzaHUxTdJvrw3rUnurB4y3SkK8YKtySLTjzn5Go9Tdl3InFtP1OZeyX03vl/ibxnDhFzKJekb71rwtYmiPlHKqM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XuE2nmQa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuE2nmQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788821081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b1TxJUQX49cLbWEB/ivNKBx96Wq16OEvm5/00tKxapE=;
	b=XuE2nmQa5e8UffNDsJhoaMT/OrX9tn6U48pd9UoxJj0qfbbJ7FGHeeC3Wo55pGXfZ6c/wZ
	4NzSdg3tzoZ1z0q2ocD/fcpBwNOudcEK3UZZzkJe/CSmQFsR6UnbYLIR/rFiynQptk34U4
	thCfTCr00aILxT5887VRgQ6kFMRsdK8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-rhwnyy5rO7WukC_7-0AUog-1; Mon,
 07 Sep 2026 18:44:39 -0400
X-MC-Unique: rhwnyy5rO7WukC_7-0AUog-1
X-Mimecast-MFC-AGG-ID: rhwnyy5rO7WukC_7-0AUog_1788821078
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E1A21800656;
	Mon,  7 Sep 2026 22:44:38 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D48F11956042;
	Mon,  7 Sep 2026 22:44:20 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  8 Sep 2026 00:44:37 +0200 (CEST)
Date: Tue, 8 Sep 2026 00:44:19 +0200
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
Message-ID: <ap8-QwC3JLDCQdcL@redhat.com>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-6-ye.liu@linux.dev>
 <ap7dC-LWNaoPYJvv@gourry-fedora-PF4VCD3F>
 <ap76-0-hN6CAcYXX@redhat.com>
 <ap8mgnpE7D4TTrno@gourry-fedora-PF4VCD3F>
 <ap8yoW37GY17pHYS@redhat.com>
 <ap83lNf0bUXX4ZS8@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap83lNf0bUXX4ZS8@gourry-fedora-PF4VCD3F>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/07, Gregory Price wrote:
>
> On Mon, Sep 07, 2026 at 11:54:41PM +0200, Oleg Nesterov wrote:
> > >
> > > This might be my - admittedly shallow - understanding of scoped_guard,
> > > but does scoped guard handle goto correctly?
> >
> > Yes, it does,
> >
> > > and why it's generally discouraged to mix cleanup.h and goto.
> >
> > Hmm, why? I didn't know...
> >
>
> one of the reasons to use cleanup.h it is to eliminate the "goto
> for exit cleanup" mechanism in the first place (says so in the first
> paragraph of cleanup.h).
>
> Later in the header is explicit says don't mix:
>
>  * Lastly, given that the benefit of cleanup helpers is removal of
>  * "goto", and that the "goto" statement can jump between scopes, the
>  * expectation is that usage of "goto" and cleanup helpers is never
>  * mixed in the same function. I.e. for a given routine, convert all
>  * resources that need a "goto" cleanup to scope-based cleanup, or
>  * convert none of them.
>
> This particular patch only does a partial conversion - so it's a
> bit of an anti-pattern.

Ah, thanks, now I see what you meant.

Perhaps in this sense this particular change is "anti-pattern", even
if "goto out" jumps out of the scope...

To me the code looks better with this change, but of course this is
subjective.

Oleg.

