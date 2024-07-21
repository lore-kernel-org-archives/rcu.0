Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2856944E;
	Sun, 21 Jul 2024 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721580280; cv=none; b=kuEf3UH0scCfxDfFZih7Tyefz77D0Ont9AF/79fBeo8+CGhYOFRGXcQEvr2b3D0XUAnAWvdToStDpVYTbUHDaj4Rn15kKo4jVjC29XtwF9ZUo4fqGaCM2zBZzX0oj+As5q7vHEMmSTU39Ry6Mghyg/cFFxX9urs0sxXsE8ApT3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721580280; c=relaxed/simple;
	bh=0eTkErHNvsDyf36hNtBQ3p5kyOxI7Jmpu0nuxZlXS+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g19pU5SrHZLwaoMtoDZFPOve0K95X2ZzYy3RUBuTkFfK2/LJrnDgA3onmEX/I8TrksF+hv95BE97zJD9L2SuQWoT0SPeDAdDLRkHX6eSeW5TkpMgOxrN+Z14yz7trT9tSYhslmHQA6jzEDxDnytfSkP4CWmAFyTQNZc7csjiXec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opppryD5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opppryD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466DEC116B1;
	Sun, 21 Jul 2024 16:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721580280;
	bh=0eTkErHNvsDyf36hNtBQ3p5kyOxI7Jmpu0nuxZlXS+Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=opppryD5/I1nfkq/uz3/SC/gVQAxT3a8BrR0e2VvOLIEZE/Wln3hKpLMnOv1nJH3+
	 0Y70VuK9IlbGE6sM6P9n4qZEVQFJX8nyNE8Tq7FUt14PR04HyhrqEiHljW0SDFEtUS
	 npwMjP0xFRa7/84BOLH2GXXEL52IdIQF8Qx8YiZt553vzqd9PHOs5CcrQUd/wcD4T3
	 KOgoFdmGTIedJFEq4PYHUux86p6tnx5st/B+62NVDylR4eyr19+Osze8VqqkMnmh+u
	 7RzOnd62sLniBbH1uiz75EDWBVYd3iH2wzU6gzLOeK2a7sNxU3yzdN2HFLUP1INfqf
	 1c+RcNqRNCoRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D92F7CE09D8; Sun, 21 Jul 2024 09:44:39 -0700 (PDT)
Date: Sun, 21 Jul 2024 09:44:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] refscale: Optimize process_durations()
Message-ID: <f66e1272-6462-4314-bcbb-aff150c31ee2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <77d6d8ee94d7149e6c33b10b78b43daf48ab8c70.1721546569.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d6d8ee94d7149e6c33b10b78b43daf48ab8c70.1721546569.git.christophe.jaillet@wanadoo.fr>

On Sun, Jul 21, 2024 at 09:23:46AM +0200, Christophe JAILLET wrote:
> process_durations() is not a hot path, but there is no good reason to
> iterate over and over the data already in 'buf'.
> 
> Using a seq_buf saves some useless strcat() and the need of a temp buffer.
> Data is written directly at the correct place.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is compile tested only.
> I introduced a bug in v1 (see 1st item in the changes below), so it should
> definitively be tested by someone!
> 
> v1 was un-usable because seq_buf_putc() was not exported. It is now
> available since v6.7.
> 
> Because of the changes, I don't know if the previous R-b should kept.
> In case, it was:
> 	Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 	Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

It would be good for them to take another look.  In the meantime:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> Changes in v2:
>   - Use seq_buf_printf() alseo for the first string, otherwise it would
>     get lost
>   - Use seq_buf_str() instead of seq_buf_terminate() because the API has
>     changed
> 
> v1: https://lore.kernel.org/all/bbbab32e3e104bdc2238724a6a4a85e539f49ddd.1698512661.git.christophe.jaillet@wanadoo.fr/
> ---
>  kernel/rcu/refscale.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index f4ea5b1ec068..cfec0648e141 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -28,6 +28,7 @@
>  #include <linux/rcupdate_trace.h>
>  #include <linux/reboot.h>
>  #include <linux/sched.h>
> +#include <linux/seq_buf.h>
>  #include <linux/spinlock.h>
>  #include <linux/smp.h>
>  #include <linux/stat.h>
> @@ -891,32 +892,34 @@ static u64 process_durations(int n)
>  {
>  	int i;
>  	struct reader_task *rt;
> -	char buf1[64];
> +	struct seq_buf s;
>  	char *buf;
>  	u64 sum = 0;
>  
>  	buf = kmalloc(800 + 64, GFP_KERNEL);
>  	if (!buf)
>  		return 0;
> -	buf[0] = 0;
> -	sprintf(buf, "Experiment #%d (Format: <THREAD-NUM>:<Total loop time in ns>)",
> -		exp_idx);
> +	seq_buf_init(&s, buf, 800 + 64);
> +
> +	seq_buf_printf(&s, "Experiment #%d (Format: <THREAD-NUM>:<Total loop time in ns>)",
> +		       exp_idx);
>  
>  	for (i = 0; i < n && !torture_must_stop(); i++) {
>  		rt = &(reader_tasks[i]);
> -		sprintf(buf1, "%d: %llu\t", i, rt->last_duration_ns);
>  
>  		if (i % 5 == 0)
> -			strcat(buf, "\n");
> -		if (strlen(buf) >= 800) {
> -			pr_alert("%s", buf);
> -			buf[0] = 0;
> +			seq_buf_putc(&s, '\n');
> +
> +		if (seq_buf_used(&s) >= 800) {
> +			pr_alert("%s", seq_buf_str(&s));
> +			seq_buf_clear(&s);
>  		}
> -		strcat(buf, buf1);
> +
> +		seq_buf_printf(&s, "%d: %llu\t", i, rt->last_duration_ns);
>  
>  		sum += rt->last_duration_ns;
>  	}
> -	pr_alert("%s\n", buf);
> +	pr_alert("%s\n", seq_buf_str(&s));
>  
>  	kfree(buf);
>  	return sum;
> -- 
> 2.45.2
> 
> 
