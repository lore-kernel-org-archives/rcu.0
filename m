Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BA84477F3;
	Mon,  7 Sep 2026 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784041; cv=none; b=itPOInjcJFq/fdwcsNa6+mkrfxv8cE+SKatnogNXgAOLdxIHwVPgLU0gsVsloLD0ia8nlN3c61HhH0JvIozFOtJgpX4NNM/hVXje/k4Bm5TmHoVQlnKiDPjwWRmWK2B+TPQlp9VDZV9kHJZDXvVt+wCH1E0d1ZVyNvsltmP58u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784041; c=relaxed/simple;
	bh=4KhMUWrVeTM3TUi3xbt6hV73HS/X/W7s3ec217rpnDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQqIJGFICdQQWygMiK/HHKzQWKETk6kdHoVBHN3TEru+ZWJ/tZ3kp8w97+wUJ8/zzH07YTLe/jtAszo0G+lW6Ji0igyeXKuqUT2UL7z8fckYJauhfJsIPg2rbwFMyVChl2miieqJ788PtARIbkB19Hgay0stdH2f0hD+knroI98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBJkmeHo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBJkmeHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8107A1F00A3A;
	Mon,  7 Sep 2026 12:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788784039;
	bh=FON6q6qStRwddcTjTo4OO7kzte1WdlEtk70KYE6DEZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hBJkmeHoo3adk3zkUC7eYlw8h/TJyFQC7PnBfhei3eMbML+nMpxFUdoab8vEGHrC8
	 qv1TOSO6hpNr8vp5zd2I50DVcVBN2gbGEAaCVwtfnjCLuQaAOdZeOlXR/p7+Z4JKeP
	 9TN2uOi8STQr/J/OHftEHtUR0UvWj+6PFSAan524lD3d6akZQ7EehNCueclrUrGHOR
	 8ejbl/+TwuNme7llFf+Fy/j3D1/HZyvT3e7tKvC0GorCTf0v4LFtXuURtE7JiUbqv4
	 nlEE6828TnKP1RT6mAXgU/uOPKyk9IkmccHdH3cVzbR9hDg5I7E6j9AKneb4a6l/SN
	 0ymItKMeX+E/w==
Date: Mon, 7 Sep 2026 13:27:03 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, "David Hildenbrand (arm)" <david@kernel.org>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Ye Liu <liuye@kylinos.cn>, 
	Michal Hocko <mhocko@suse.com>, peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, 
	rostedt@goodmis.org, jpoimboe@kernel.org, mic@digikod.net, tglx@kernel.org, 
	linmiaohe@huawei.com, nao.horiguchi@gmail.com, rafael@kernel.org, gnoack3000@gmail.com, 
	sj@kernel.org, rientjes@google.com, shakeel.butt@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, lance.yang@linux.dev, 
	mhiramat@kernel.org, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 6/8] fs: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <ap6tk14FFBAYaQNe@gremlin>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-7-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-7-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:32PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
>
> Replace the manual rcu_read_lock()/rcu_read_unlock() pairs combined
> with for_each_process() and for_each_process_thread() loops in fs/
> with the for_each_*_rculock() macros, which scope the RCU read lock
> to the loop body via scoped_guard(rcu).
>
> No functional change.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> Changes in v2:
>   - Rename *_rcu to *_rculock
>  fs/proc/base.c        | 4 +---
>  fs/resctrl/rdtgroup.c | 8 ++------
>  2 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 6a39de424f62..3de4f4557e4c 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1160,8 +1160,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  	if (mm) {
>  		struct task_struct *p;
>
> -		rcu_read_lock();
> -		for_each_process(p) {
> +		for_each_process_rculock(p) {
>  			if (same_thread_group(task, p))
>  				continue;
>
> @@ -1177,7 +1176,6 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  			}
>  			task_unlock(p);
>  		}
> -		rcu_read_unlock();
>  		mmdrop(mm);
>  	}
>  err_unlock:
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 5dcbb0a964e8..b14df8b23f1a 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -709,14 +709,12 @@ int rdtgroup_tasks_assigned(struct rdtgroup *r)
>
>  	lockdep_assert_held(&rdtgroup_mutex);
>
> -	rcu_read_lock();
> -	for_each_process_thread(p, t) {
> +	for_each_process_thread_rculock(p, t) {
>  		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
>  			ret = 1;
>  			break;
>  		}
>  	}
> -	rcu_read_unlock();
>
>  	return ret;
>  }
> @@ -826,15 +824,13 @@ static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
>  	struct task_struct *p, *t;
>  	pid_t pid;
>
> -	rcu_read_lock();
> -	for_each_process_thread(p, t) {
> +	for_each_process_thread_rculock(p, t) {
>  		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
>  			pid = task_pid_vnr(t);
>  			if (pid)
>  				seq_printf(s, "%d\n", pid);
>  		}
>  	}
> -	rcu_read_unlock();
>  }
>
>  static int rdtgroup_tasks_show(struct kernfs_open_file *of,
> --
> 2.25.1
>

--
Cheers, Lorenzo
