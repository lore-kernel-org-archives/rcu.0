Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548863947B5;
	Mon,  7 Sep 2026 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816065; cv=none; b=QQ0f1pwYfu+oKl6EY7E0LSXRex2ESC8sT/7+qhVmRBnSTb0yD8BNELxhzK04Xdu6npA8H82A7/76ugsC9FbSpOIRXemUGfxuU0ni5tkgWIthBO9hOYTJMii5+DtzJZthJKZTV3L4Mr6Pb3FY2+skQ6Z7ta7vzO4Ep/0Sb1qkEPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816065; c=relaxed/simple;
	bh=V9yGKxsKBkzGlAC/hxr45uH1WKzdDVp5+NrxU6z4lgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuwajmAGruoS9eCjJyHiLO3NpMlqtqsJ4ZC4fKhdhzEbZGQErJuDrYT3ZKfEYPiP8pW0eLFug0LGiptJLZE7+U3LVLfMuVJT2CJxlg8o66IEkBwWszMWoSKr38cncwxwzXgim9I6hYRC07/+L2v1zgV6ER1/j+guUHb2QdyBtBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUQkhQ1k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUQkhQ1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983371F00A3A;
	Mon,  7 Sep 2026 21:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788816063;
	bh=zZDIy90AzlSJ3HlZ3+CMlS3Mw3yleXCGFSv0h6VAF+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OUQkhQ1kaTnohHzsTD/U1pPnsHjT6rvQ3f/w6+onI/QqztgFCl862h/l1jvdiRwGO
	 HIwWitHkFqgczyVPMD14Z+QtwsTHkhMqqUbxZTmikC1VuKKNoy3nLeJiy+uXwLQwAa
	 3DyDfdWZJ9XyTZcRuPQWBYlVsHaY4C1EaxMfbiU/HCmWOu/ESFkhPpzuO5oj4jRwBa
	 igDRSTQq9ByM7IJeQb/Z6uV/dua/ndO2LtrY3DLY6qLqPKTWA3IWuaxix+chZH6P/j
	 2xfJyD0IgfjTwSV8NwnwlgyvrVcA5eYt6cDfWsmzbOKNh51XjwM91R7pkpZu9pwQXM
	 er8pZGGr3aTXg==
From: SJ Park <sj@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Ye Liu <liuye@kylinos.cn>,
	Tejun Heo <tj@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Yi Tao <escape@linux.alibaba.com>,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	mic@digikod.net,
	tglx@kernel.org,
	akpm@linux-foundation.org,
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
Subject: Re: [PATCH v2 1/8] sched: introduce for_each_process_rculock and for_each_thread_rculock
Date: Mon,  7 Sep 2026 14:20:53 -0700
Message-ID: <20260907212054.88063-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081334.1152889-2-ye.liu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  7 Sep 2026 16:13:27 +0800 Ye Liu <ye.liu@linux.dev> wrote:

> From: Ye Liu <liuye@kylinos.cn>
> 
> Introduce for_each_process_rculock(), for_each_thread_rculock() and
> for_each_process_thread_rculock() macros that acquire the RCU read
> lock before the iteration starts and release it when the loop is left,
> so that the RCU read-side critical section is scoped to the loop body
> instead of an externally managed rcu_read_lock()/rcu_read_unlock()
> pair.

Looks good to me.

> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>

Assuming Lorenzo's indentation change requests are accepted,

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
