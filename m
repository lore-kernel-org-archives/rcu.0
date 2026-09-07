Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F5F42467C;
	Mon,  7 Sep 2026 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769861; cv=none; b=OlfwQsJ9BITmGuJca9NuR7dA5mOQ2Y6XoU6ksrGOI+qiThzw9TCgmqq5ldVhABtrpICx0BLKWMwdZyS2Uk5Qhu+aL/bUgMKCK8g83pmjftRggrrv0MMcbz9CCIwxFER2XgLe5ezfBLVxTIAqQkCPiA9DCF6BWtfbNiBYOsAIukE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769861; c=relaxed/simple;
	bh=UyvTApDFSHUTrEMxF7m1O9nQZ0M3f/YbiPyyL5h8X64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzKfNL985iccZ3kA+QUU66Y9/H6veNmL95rvcHnOnMCbqCcv+Ha07DwbTKR9Rs7Gp9lqnrSYGl/o7ibgEAGf1rhF6gYs5kAWAlvdOizbYlMxoqBgumXjxcoB/1OXUwQu/tDzEoBPASyRecNhdrwufyII7dyVzOHBhJT4GZf8UNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDdbDc9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDdbDc9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98A01F00A3A;
	Mon,  7 Sep 2026 08:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788769860;
	bh=C3Qj5aYZdoYUGz5K6Ve4x0QUot1tBZloGgZLRhBtw34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CDdbDc9xHCMS30v5MjFDnxUKCRYcq4sLDVR7heIyRnV3dVUWiz3jSR21p2tC8tLY0
	 a5ppuV7Oq3pqn1sm26nImkiVnwzWnY4nIQpm5AtJmpDSLfdRBixMkHYcZYNNP+KKIb
	 V+8S6YT+pI9Ac75JoyFDjT5kVsmPyq3bHmp0UAu48vzyqptOu/DDxVdfhBdKPZMXxt
	 LiYaNk1vnoX3Zi8LMh3SGY/hQ7VNY8eF5BGTFWspXDc9TtjKf6v0/YhUdmqpfrdnNY
	 bLDNFrftjN8cE6OpOzzSLk//d9oDXTHlaIIWcd08zyic+FHuWNK9TPoDFmcRsKANU2
	 WIu8oYXSV7NUA==
Date: Mon, 7 Sep 2026 09:30:44 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Ye Liu <liuye@kylinos.cn>, 
	Tejun Heo <tj@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Yi Tao <escape@linux.alibaba.com>, 
	Michal Hocko <mhocko@suse.com>, paulmck@kernel.org, mingo@redhat.com, rostedt@goodmis.org, 
	jpoimboe@kernel.org, mic@digikod.net, tglx@kernel.org, akpm@linux-foundation.org, 
	david@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, rafael@kernel.org, 
	gnoack3000@gmail.com, sj@kernel.org, rientjes@google.com, shakeel.butt@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, 
	lance.yang@linux.dev, mhiramat@kernel.org, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/8] sched: introduce for_each_process_rculock and
 for_each_thread_rculock
Message-ID: <ap51Mj0cqvAYb31k@gremlin>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-2-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-2-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:27PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
>
> Introduce for_each_process_rculock(), for_each_thread_rculock() and
> for_each_process_thread_rculock() macros that acquire the RCU read
> lock before the iteration starts and release it when the loop is left,
> so that the RCU read-side critical section is scoped to the loop body
> instead of an externally managed rcu_read_lock()/rcu_read_unlock()
> pair.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>

Some nits below, with those addressed, LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> Changes in v2:
>   - Rename macros from *_rcu to *_rculock (Steven Rostedt, Thomas Gleixner)
>   - Improve comment on for_each_process_thread_rculock() double loop
>   - Change prefix from mm: to sched: (Michal Hocko)
>  include/linux/sched/signal.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 584ae88b435e..110ea9f131f3 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_SCHED_SIGNAL_H
>  #define _LINUX_SCHED_SIGNAL_H
>
> +#include <linux/cleanup.h>
>  #include <linux/rculist.h>
>  #include <linux/signal.h>
>  #include <linux/sched.h>
> @@ -663,6 +664,30 @@ extern bool current_is_single_threaded(void);
>  #define for_each_process_thread(p, t)	\
>  	for_each_process(p) for_each_thread(p, t)
>
> +/*
> + * Variants of for_each_process(), for_each_thread() and
> + * for_each_process_thread() that automatically acquire and release the
> + * RCU read lock via scoped_guard(rcu).  The lock is held for the
> + * duration of the loop and released on exit, including via break,
> + * goto, or return.
> + */
> +#define for_each_process_rculock(p) \
> +	scoped_guard(rcu) \
> +	for (p = &init_task ; (p = next_task(p)) != &init_task ; )

NIT: Can you indent the for loop by a tab? Since the for is in
scoped_guard() scope and that's not made clear.

> +
> +#define for_each_thread_rculock(p, t) \
> +	scoped_guard(rcu) \
> +	__for_each_thread((p)->signal, t)

Same comment as above.

> +
> +/*
> + * Double loop: 'break' only exits the inner for_each_thread() loop.
> + * Use 'goto' to exit both loops; the RCU read lock is released
> + * automatically when the scoped_guard scope is left.
> + */
> +#define for_each_process_thread_rculock(p, t) \
> +	scoped_guard(rcu) \
> +	for_each_process(p) for_each_thread(p, t)

Yeah this is even worse for clarity :) I know the existing defines do itg
this way but it's kinda confusing.

I know it's a bit fugly, but it's MUCH clearer as:

	#define for_each_process_thread_rculock(p, t) \
		scoped_guard(rcu) \
			for_each_process(p) \
				for_each_thread(p, t)

> +
>  typedef int (*proc_visitor)(struct task_struct *p, void *data);
>  void walk_process_tree(struct task_struct *top, proc_visitor, void *);
>
> --
> 2.25.1
>

--
Cheers, Lorenzo
