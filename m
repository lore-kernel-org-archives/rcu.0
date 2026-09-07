Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51B13546C1;
	Mon,  7 Sep 2026 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816551; cv=none; b=doJ85ZrDpX2hU6KzKuxm3wTnBD1IOLcAGloQlttz3cIYP8ND4WUx+znuZyxwuUDrNbeQSC2hwpV0yNON/iNnObw0a+3pwgT37Z5Jz78p8AaT9gxymFkcylDRk/SyOyqg7IqI4ZcC7jacl5xlJVCMxhR8P1g21fa/TBmAHGwjZc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816551; c=relaxed/simple;
	bh=yAs96O0yppt/Yb0wr2Shwx2NF5vjnpTEq92J5LGfixE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVwVqGjeSazyargHq9IDGjXCA/5a6ORHM0h5+5PawsinInfNzi9KnNdwb+rYDzuYlkGdr+dwHWqk0iOXLZeAd5MJ6bDbu6rP2V9sje164xB+V/yJXyH8OW4rN4QYSQ0RFy7ovh8h/XksyTZ5dCQlJdtpHodWzJE8RHcCMkNX7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEkeflrW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEkeflrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E0E1F00A3A;
	Mon,  7 Sep 2026 21:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788816549;
	bh=SCl+jEvdrjqF72ntttZG2eEJe2zsb8hqXfy1vCrvzWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mEkeflrWN0r6Z+I8Juu6xf4YbiwhChACWok2YclBi8b5nJBlIpqf1i1momt9AzMLn
	 HI1QtdkqTbNw4Jerj49Q9WTpWX98qUbvbygdjgic02n/DaTSMEahTmlv1lPyfkNLUM
	 WYq/jtyC+ORcrpiixiCUqCGT3HhBkClPjn+0e1dhgw14q14WbqLaTNBJ1+rTTBFm0z
	 Wo+OnNoio7rYWCJuwuHi8LhB5Cz3YZD+JVd+OY+K/vMlx6/4gF71U4NBaqZ8jahuv/
	 zpeq5EIJQp6qYxFG4w7AcQ9aa36+t+qChh4tHUDjmdDzzGm6jRaybZIc0+0lUtQj6p
	 kQif/l2wruLaA==
From: SJ Park <sj@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
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
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	mic@digikod.net,
	oleg@redhat.com,
	david@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	gnoack3000@gmail.com,
	ljs@kernel.org,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	x86@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	pavel@kernel.org,
	lance.yang@linux.dev,
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
Subject: Re: [PATCH v2 5/8] kernel: convert process/thread iterators to for_each_*_rculock
Date: Mon,  7 Sep 2026 14:28:59 -0700
Message-ID: <20260907212900.88422-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081334.1152889-6-ye.liu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  7 Sep 2026 16:13:31 +0800 Ye Liu <ye.liu@linux.dev> wrote:

> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() and guard(rcu)
> pairs combined with for_each_process(), for_each_thread() and
> for_each_process_thread() loops across kernel/ with the
> for_each_*_rculock() macros, which scope the RCU read lock to the
> loop body via scoped_guard(rcu).
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
