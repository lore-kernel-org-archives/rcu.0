Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E49A45FFB6;
	Mon,  7 Sep 2026 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784160; cv=none; b=uwyTvlsHS/UIs2V507blwL/IZemTs3C+XYb3iPL8t6H8VDlPG71v3pzGGbcyhGvUbnj0EUf77CEgLT9SAxilrlWOL9ft9RWQ3V9a4fccdxl6goCCePsynp40cs1vevsfZ68USdT8bpm22w1g07534B+3NFk9UpFUgJ3G/IaczG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784160; c=relaxed/simple;
	bh=4rNnuwidxDHWV2F70P8hly3lNLDXFmxjWe9qZFUPRR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKvyap8Yh+kHOcX7uZCnHtcodhXVeObpSBbUV50AIyd1YuPGuxMk1pFWXw55NzfjmKik5pOPeouFjEDU9lsJI5Uo0+u6Eb43+pXf046Axeny+TM//bQIN8ZSOMZjkX6cLej0MISFC9VhlifkHdM/RBgtvx2uh7Z+TtydezIDnXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SamNaLe7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SamNaLe7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AD31F00A3A;
	Mon,  7 Sep 2026 12:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788784153;
	bh=MkDAwsqxGaceGfRmb6vtMU2HC0ErrGFG0sZSl2jCjh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SamNaLe7XhM1e5/SCg2UgqFLGHgOX0ZA7pci54ayVgh1r8Aa55xnUGKXJAcXwXy5D
	 tqGvIh/XnRv4Hr7k9h41IgEicJAdSCkZVXyjftuoH4uK+RSIEmBmOSABpe0xrbDE8b
	 3qACI5xnCV9khLFq/VQhNPw5VtMvpDBkiIkCOQCN/Elv0GLgSAuqtU4KGpTPp8RW5X
	 zcnz0ltm0IOaEnc8QEzYn8HP8eCs9CXs8E95BdP4T9MhQUB1AdMw6MTRom0KD24wt7
	 nH4p7Uiva5uk0ptmQENNZ5ZMEh3OjS8AY1UoxR/HBNIh9NVkIDTyLYc1wUMeE/XfiY
	 RYaMoruOloQsA==
Date: Mon, 7 Sep 2026 13:28:57 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Ye Liu <liuye@kylinos.cn>, 
	Justin Suess <utilityemal77@gmail.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	mhocko@suse.com, peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, 
	rostedt@goodmis.org, jpoimboe@kernel.org, oleg@redhat.com, tglx@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, 
	rafael@kernel.org, sj@kernel.org, rientjes@google.com, shakeel.butt@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	pavel@kernel.org, lance.yang@linux.dev, mhiramat@kernel.org, pmladek@suse.com, 
	longman@redhat.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang@linux.dev, dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, mark.rutland@arm.com, 
	Dave.Martin@arm.com, james.morse@arm.com, babu.moger@amd.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rcu@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 8/8] security/landlock: convert thread iterator to
 for_each_thread_rculock
Message-ID: <ap6t3Dyf-tLJ4Yfw@gremlin>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-9-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907081334.1152889-9-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:34PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
>
> Replace guard(rcu)() + for_each_thread() with for_each_thread_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
>
> No functional change.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Reviewed-by: Justin Suess <utilityemal77@gmail.com>
> Reviewed-by: Günther Noack <gnoack3000@gmail.com>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> Changes in v2:
>   - Rename *_rcu to *_rculock
>  security/landlock/tsync.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index 0b71e158c3f5..a578af640aad 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -335,9 +335,7 @@ static size_t count_additional_threads(const struct tsync_works *works)
>
>  	caller = current;
>
> -	guard(rcu)();

OK looked at the file and confirmed the function exits just after the below
section so fine :)

> -
> -	for_each_thread(caller, thread) {
> +	for_each_thread_rculock(caller, thread) {
>  		/* Skip current, since it is initiating the sync. */
>  		if (thread == caller)
>  			continue;
> @@ -376,9 +374,7 @@ static bool schedule_task_work(struct tsync_works *works,
>
>  	caller = current;
>
> -	guard(rcu)();

Similar here.

> -
> -	for_each_thread(caller, thread) {
> +	for_each_thread_rculock(caller, thread) {
>  		/* Skip current, since it is initiating the sync. */
>  		if (thread == caller)
>  			continue;
> --
> 2.25.1
>

--
Cheers, Lorenzo
