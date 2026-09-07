Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244DB423A6C;
	Mon,  7 Sep 2026 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816308; cv=none; b=uCEUzCeH1CLicaBMy+jxvQJJ1dwueq650ji4ODHx0+173+r3zjdIOdcuXqBQR3cPSsTScn7hV5hSzDmlF+phgBrMh6nvqDTmR2ORUtmiciF2VrSWZfMZ3obFzJU9MfumnI0HjowlYNG7Cr9r4fEnDTc6In/mYCGaeZWx2Re36b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816308; c=relaxed/simple;
	bh=z/PxfvviLLTFugbGZPcf/FuvmD/zRDYhjBU3T1yQooc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfuDtw/eQzwoo1vGHcA4S843FHMkJAITKaFO2a36bBmgiLWf+AKsy9J7TWv1mtQJY/Fr8gYQioODy5WrECheeD8nlytR+rlcWLbUKT4REFZwkQkGxOVWlAPeOjl9WcnJ2i5Rc940uQNGuAwRJAFuAKiSC45b6R3/h1Yrhummd1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOBDXX8q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOBDXX8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750261F00A3E;
	Mon,  7 Sep 2026 21:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788816306;
	bh=CGH0z6eCbi75StZiFhp1/k3e2S59+73Cki+MY1VrPg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZOBDXX8qIyCCRdOP6tmA1KKhaSnjDoxcs35+x3T6KqIIusFXAjWJYrBMBEuco732f
	 2aucM9Ce26EMBbOtvMfVw5m3uXDmIwn75EbcQwOgTfa41bAvJkGvHUkD0LqeP68xaO
	 WXvKxA1HV/VFth7JkNkkD28247+PWkJqzXGr9urxogjw99Bfe5QZqorMT5PhKjqEPm
	 sbr0RFQP4JKb320CuP8R4H7nGOAk8d8njNUH7L5BnvlQtXPuY+B5/TUe0K1mym+3kh
	 E77o10jT7QSqMsVnSpIkTOivSqbfl3yuMr0KsodwV68Qx86U7CG2okAg1UYJ6DuFuO
	 /QlNjIUZ7JYxA==
From: SJ Park <sj@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	peterz@infradead.org,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	mic@digikod.net,
	oleg@redhat.com,
	tglx@kernel.org,
	david@kernel.org,
	nao.horiguchi@gmail.com,
	rafael@kernel.org,
	gnoack3000@gmail.com,
	ljs@kernel.org,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	will@kernel.org,
	boqun@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	x86@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	pavel@kernel.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	pmladek@suse.com,
	longman@redhat.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	mark.rutland@arm.com,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 4/8] mm/memory-failure: convert process iterator to for_each_process_rculock
Date: Mon,  7 Sep 2026 14:24:57 -0700
Message-ID: <20260907212457.88243-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081334.1152889-5-ye.liu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  7 Sep 2026 16:13:30 +0800 Ye Liu <ye.liu@linux.dev> wrote:

> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pairs combined
> with for_each_process() loop in mm/memory-failure.c with
> for_each_process_rculock(), which scopes the RCU read lock to the
> loop body via scoped_guard(rcu).
> 
> In collect_procs_file(), the page_pgoff() call now falls outside the
> RCU read-side critical section.  This is safe because page_pgoff()
> only reads folio->index and does not traverse any RCU-protected
> structures.

Thank you for clarifying :)

> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
