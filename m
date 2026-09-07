Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EFA43A809
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796439; cv=none; b=FuwFt/lyGdxGNbxBdQ4ezyuOmQWWbrDvU30kxYHr8ENBq9mHa1WeCnQiOSeStMjP5hedASVCZQknSwlGeAi1rpztUirLqPOcRwsY2v5hHO4/SP3XNavMuYfu4Q4TBiaQl4e+olHQ/4A6/i2eZoKx2z7q5pZAskGWcFnA6UQfsBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796439; c=relaxed/simple;
	bh=kdW80z8QSijQXKWXMTATEq/l6KVSa+t5CIJEX8QYy6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iy7b5uvolYbLbf9cG8xfimnQ7eIAfvvKFfXvjvl4SEj92PG0tL/q9C3I+Zpe8z4RORYNbcpC97dVJ8V5El8dB/TDMmrx97wR6PQj5XYuNsuDDRyZnCiYEfFLl5iESf9Kj1wnIt90O4FcHf51F13QEG6ie4OucY1ftaKhp50R+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ct/qjgub; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ct/qjgub"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-90e970f710cso41344536d6.3
        for <rcu@vger.kernel.org>; Mon, 07 Sep 2026 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788796435; x=1789401235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MpjJCtF9a7Ao8JicOrb9fcW3ZU3uKqej/fz3Z0ryD7g=;
        b=Ct/qjgubq83YDJuMY08ToLOHwyKEQAwm5/0XgADGkzXP/clOU6nt0U4E2QnUwbl9Ym
         4+G7A8NlhptRM84KvYs42cjxX0FLUrShBMnPRYud/Iy6CauD5sBoOmOCLhxOOXiDIe05
         2AzWTldRciiRFeRxCDYwLrU3sVqlLqmsm23QSOMa0r41Ga53oGwtbc6Iz7SPupKP7msQ
         k8kAh0dn52fzlA3KbLMr3dJn95x5embEN/wOPU7Z1nwZkwB4hgqkaZh/dbr4JIDaB3gB
         lWciwpHEO2RE0uIh4WpGSQMfrYNwG3jq2xZ4qWc7HQx+wCfO5pp2mS8p9as7Cy6fGzZ1
         F6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796435; x=1789401235;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MpjJCtF9a7Ao8JicOrb9fcW3ZU3uKqej/fz3Z0ryD7g=;
        b=ITf3j/9SEPlaGt9PRDuf3fEcQmR7n27BgoOMvH7bsdpVzgFFtGek3V8fpmKlRup/Gg
         BYEjFWWAFoMzIm+VszMSyhmGkI0nKT/RZ/aZxCoIS98VgvCp9Al/8pNdhS0zffi5blkH
         oWbHyHBMMJm0TXgPr7039kRCaathpP5WsUIsHFvPsKmTDBDy73hmaK9et81b/U4RnrW4
         vRng5CSGQZhtX2vcnKdB6cCLR+6r9zNo6YesJG23jU+QXUJmwdmI8th1MD66r0CZh47/
         gOnI0KvP9VXtPZEbvSbDMHpAVqmraPVxMukXRCfJJgEIeUhnodnewtuHCuSKXgrCBVis
         wgJQ==
X-Forwarded-Encrypted: i=1; AKwUvByqufNju4E/eH4phgh6m+zDe8XA6od5+mSO3MfYydp42g2RsJegK+TIinsYPU4jbD/4BiQ=@vger.kernel.org
X-Gm-Message-State: AFuF++no+8xoUqIiOo2cCP1Xo/Wlr6Sh0C3mSTc5jeHzFDfc5fg/uROv
	sRvCECgmgTMmHYgdQuteQvDAdd6VpmmdLR0o0WAbpuzvJXpQfoAMT/DH7CcqaTsCHpg=
X-Gm-Gg: AYBFou3kbcIewoUzGKByq8Glh8DooN+gSalsN2nt14lsAUsXFju+8e2X+ivIoiwbm3W
	VuJ6LwxuvjofKoOR8s9Q5fQdzdpHMn430US8FNLHb+wX+TR4z40NOuY18pon4pZlTxyLzObIJpH
	AyMNwyW0ZrprJWE/QuN/fYfOb1xifUhSJ4HDf+T4Qs/nhztHQ7Ocste3WRJfpk2xFgASsdiuvLH
	O17wxAgHW/DYPMofeHyoLZZsCktl0uPsReY+y4XhCmGCIq8prXhOi2zbYeEvYJ3h4y6KnFlPG08
	9wpyH1mSkFmGV7MhoHBptDr+fwzHRiRo/2UgIlid45lVyGU3XiBXYzciUVAvDPoJpdjb77tnufX
	9jB/5hU+wubduLnccNwa3JSQ/eGozPcDecIua/Z4KHxQBWeks15jPkz9UwpmljdVtNXXfUIoZsh
	fNYsIwxVdUWLT/VYcB/8TLvdj46zCtqdlUlp7idpVjGeaglB4tL0LCQNrFWE/UlEpXMSo7Uq4Tx
	wcnKVnHtY4syU0JxKP2JriEJo+ko9kimduenNrcc11Q
X-Received: by 2002:a05:620a:851d:b0:939:6de8:43e3 with SMTP id af79cd13be357-939804cc15amr1836196285a.48.1788796434937;
        Mon, 07 Sep 2026 08:53:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb59c72sm907982585a.26.2026.09.07.08.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:53:54 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:53:51 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Ye Liu <liuye@kylinos.cn>, 
	Michal Hocko <mhocko@suse.com>, mic@digikod.net, oleg@redhat.com, david@kernel.org, 
	linmiaohe@huawei.com, nao.horiguchi@gmail.com, gnoack3000@gmail.com, ljs@kernel.org, 
	sj@kernel.org, rientjes@google.com, shakeel.butt@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, 
	lance.yang@linux.dev, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 5/8] kernel: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <ap7dC-LWNaoPYJvv@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-6-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-6-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:31PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() and guard(rcu)
> pairs combined with for_each_process(), for_each_thread() and
> for_each_process_thread() loops across kernel/ with the
> for_each_*_rculock() macros, which scope the RCU read lock to the
> loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>

Question below

> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 6fcc94ce4ca9..73a5ad3be9a8 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -315,13 +315,12 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  		return;
>  
>  	this_round_count = 0;
> -	rcu_read_lock();
> -	for_each_process_thread(g, t) {
> +	for_each_process_thread_rculock(g, t) {
>  		if (!max_count--)
> -			goto unlock;
> +			goto out;
... snip ...
> - unlock:
> -	rcu_read_unlock();
> -
> +out:
>  	if (!this_round_count)
>  		return;
>  

The sunken rcu_read_lock()/unlock() + scoped_guard usage makes this goto
at a minimum very confusing, if not actually broken.

Are we sure this isn't broken as-written? Generally we don't mix cleanup
and goto for exactly this reason.

~Gregory
