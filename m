Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88F30F7FF;
	Mon,  7 Sep 2026 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817378; cv=none; b=SLQhOgyceJAkmsy8IMHcm0Ilv057nnj5RF93sPreWDk9vH3RDefX7x3wNWf9RTF0bli5u3t/5BVAWPSjHtPv7BmQNm/96XtDdyWNe+Fxjgb7KwpZMWma2C2j+t6KR/onVo01dY9Ez47zT0S1yA7SEZhj7Wecx86MaeyT2GrbNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817378; c=relaxed/simple;
	bh=Awel2/sCq7cTNJ5r4QvOuB8HaUFplHO4tCOdT6k/95A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGsfM3Kebpro5Xq88K2LkPsWxFN7nK21hZsYiFkPwPAh9YTDhctGC22NeTP7pfa1Z+XfcOldAsGBqvYYlPOwOW1hEZsqIjTVOLZzkV3HTgGoMazHetluOn3NNO5FBX3Nn26bTadH8A782noFvdHy7RL8ppz45MTDNuu2KWU5VBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asDN0pcU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asDN0pcU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26331F00A3A;
	Mon,  7 Sep 2026 21:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788817376;
	bh=O3ajM7rRzZOM6WqeLBJOEovDBaOSN37HTunc0pSzZyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=asDN0pcUJqeixbW9qwJ4pDOEFYm5UGI9pIRPC8d5sBq7b8Bs/RHMxQQxTh5MfSyPm
	 nav/N1Oam468mk5mYmVWd31bUW3zoeqbPCiOa5OyFY5cuGbjnxSZzmcqLnuaVwIT/w
	 piofhmeIXbNYytfqNCV1gAfRs7wxr9N2gOjFPp0G6006oG94WFURp3ZaCgySKW/5yd
	 Y7oncOZb93PUxXjRDW6LlJCPUi5u5biyjZdMT1FqmBT4zvrnShofyMbn824cgXxfFV
	 zPZBNIIQ00tuq9a9hdYjcM9C5eILXth/Bb3AXDIxO7ssRULtQ7HIjUeRqrQy1E/lxq
	 x3gwELKMoP1Jg==
From: SJ Park <sj@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: SJ Park <sj@kernel.org>,
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
	linmiaohe@huawei.com,
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
Subject: Re: [PATCH v2 7/8] lib: convert process iterator to for_each_process_rculock
Date: Mon,  7 Sep 2026 14:42:47 -0700
Message-ID: <20260907214248.88838-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081334.1152889-8-ye.liu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  7 Sep 2026 16:13:33 +0800 Ye Liu <ye.liu@linux.dev> wrote:

> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process() loop in lib/ with for_each_process_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
> 
> No functional change.

Looks good and correct to me.

> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
