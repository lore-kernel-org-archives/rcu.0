Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68292375F82;
	Mon,  7 Sep 2026 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817254; cv=none; b=F+B7+P8hGS6zPHffA67CWK22nwwF+JQLS8NWLvzErwrTHTkXDXLdIK+ddQap7zXj3vb+ufNkmT76W/0Bb8CKDMF9r2P/dwTeWOtwgKhQd5ko2PYoC52ux4OagCIxpHg0DM8POqHxkWayobnkMbfFXhXa0N4uedM4Jbtg+EENU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817254; c=relaxed/simple;
	bh=eFeUK/8VopfB6JkZhdIp+XbYOGVYzs0oQMUieTs8Da8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uClSNUkH3NY/3ZKh1IOudSD+PK2oz+71A+VR+2rAtQ4wn2KM9KvLj91QmbVrTXYWUOo79XxgSvuNj5StP3BezotZHc41F+XhTegYpdpzlZlfxTdz6Pi24V0i6j3vdeXeSNLCIbxl6bLoTCJVs0Y7w49z4vYvv7JAm8BVApk4LPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE0pyYIv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE0pyYIv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1001F00A3A;
	Mon,  7 Sep 2026 21:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788817253;
	bh=+URJUqEKl0fTxo39EvOW6Abd2LXVYYfRY7Esq7fulcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UE0pyYIvk0vio3jkCrLQyN6+XkN/xYweeR8nniFUl/2qfAC7KVfzk0v27PwfA7nA1
	 jRwk098mQw6qKGClkymTFqzrBU5IwJeY2MbeYz3EJganLj5O47iUGeeiW500wrapHc
	 dGvrG1LnLyPqBFPGV5JWA5xYwsuqcZ2p09vnT/2l5josN6K/hITJMsIfsDvo9Vy27m
	 E59Uj6NHvY09RtjyNlQw4SfjT3QGz8gFcn2Uger6n4ELkfGeTGUUW3jYVOLk7ue351
	 Dq37HIp5KeM6mrFUwmPlTDlmGzF3BQ0XYMidwrsKjXVqywsX8VLqcU33O91DyZm56U
	 7nhA3UnrqSbfQ==
From: SJ Park <sj@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	x86@kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"David Hildenbrand (arm)" <david@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	peterz@infradead.org,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	mic@digikod.net,
	tglx@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	rafael@kernel.org,
	gnoack3000@gmail.com,
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
Subject: Re: [PATCH v2 6/8] fs: convert process/thread iterators to for_each_*_rculock
Date: Mon,  7 Sep 2026 14:40:43 -0700
Message-ID: <20260907214044.88682-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081334.1152889-7-ye.liu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  7 Sep 2026 16:13:32 +0800 Ye Liu <ye.liu@linux.dev> wrote:

> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pairs combined
> with for_each_process() and for_each_process_thread() loops in fs/
> with the for_each_*_rculock() macros, which scope the RCU read lock
> to the loop body via scoped_guard(rcu).
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
