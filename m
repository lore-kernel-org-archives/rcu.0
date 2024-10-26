Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6466FB9
	for <rcu@vger.kernel.org>; Sat, 26 Oct 2024 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729904686; cv=none; b=PKN63XH4xE/hoaBXyUfjI0PDtunsdw9H7Veqro0izzubFUe/+EPllNdCX1uiAn42tvHyA3P3cV93FXhC9TvGjxOdYlig5TV6yDZC7UOV8ZsL8mrXZ+xMWqOXb/KKJZd0JKUmg3fV5pb+1vjg5namv4JuDqOM5jQHVizfUa9a05g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729904686; c=relaxed/simple;
	bh=tKv0+zY8yn0A9+l13cUq9XAZheLiMVWakex6QqMdKhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DK2ze170giQsXr7ldr5krLQTehJVy7JgGN+ZL3hqT1XgnsYHv1lDC6QEYyMtqp85yZzaZhxiLlzbmLE3GgSS1a0UHHljsgHAvKjrhQnKQkVYEW8KWE7sCudMI5BOHbA9wIdfiWXSIzEMARE6rjoGRCmsKiNcBJAOiFX09SUrm1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H49k+GP+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H49k+GP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0F5C4CEC3;
	Sat, 26 Oct 2024 01:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729904686;
	bh=tKv0+zY8yn0A9+l13cUq9XAZheLiMVWakex6QqMdKhk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=H49k+GP+IkWIvWyMqh2aVK28PQlV5TcYmJPgH3LLhWvrvDUmKv6jDfRerxqpdRgbI
	 UDCSMKvzTssRVOGp2EHopOEnPChLc/qPRpcGOIChMFzpC8uPHEl5KO3C/4o1fIwwDj
	 3fqck88AxBaeAV+9R/TcKjmTg2tFqu6kQJaGrYgMxJ/eKbQmW6dJD7g5JKI3pQu272
	 KAq+yz/8EPbOZytpiusDBdoL+UL2ghQWhYc6SeXrVWXMZozrj3F/SMUlNjFht6aTMZ
	 XqFggEXvosAVs9Ue3FoWz1OJlFsmV1jZl2JWU1p3umq3BmWXe3MTWfDX+Ekwdf46o+
	 Pw1S/VXZPxirQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C9E9DCE0D99; Fri, 25 Oct 2024 18:04:45 -0700 (PDT)
Date: Fri, 25 Oct 2024 18:04:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: rcu@vger.kernel.org
Subject: Re: [bug report] refscale: Add srcu_read_lock_lite() support using
 "srcu-lite"
Message-ID: <08a3a25e-0c83-41c1-ba07-db3e2c9ccf19@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <663547f8-3126-453d-8f9e-f9ce252d43c2@stanley.mountain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663547f8-3126-453d-8f9e-f9ce252d43c2@stanley.mountain>

On Fri, Oct 25, 2024 at 09:58:05AM +0300, Dan Carpenter wrote:
> Hello Paul E. McKenney,
> 
> Commit 1e07186d7377 ("refscale: Add srcu_read_lock_lite() support
> using "srcu-lite"") from Oct 15, 2024 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	kernel/rcu/refscale.c:1151 ref_scale_init()
> 	warn: inconsistent indenting
> 
> kernel/rcu/refscale.c
>     1141         for (i = 0; i < ARRAY_SIZE(scale_ops); i++) {
>     1142                 cur_ops = scale_ops[i]; if (strcmp(scale_type,
>     1143                 cur_ops->name) == 0)
>     1144                         break;
>     1145         }
>     1146         if (i == ARRAY_SIZE(scale_ops)) {
>     1147                 pr_alert("rcu-scale: invalid scale type: \"%s\"\n",
>     1148                 scale_type); pr_alert("rcu-scale types:"); for (i = 0;
>     1149                 i < ARRAY_SIZE(scale_ops); i++)
>     1150                         pr_cont(" %s", scale_ops[i]->name);
> --> 1151                 pr_cont("\n"); firsterr = -EINVAL; cur_ops = NULL;
>     1152                 goto unwind;
> 
> This looks like you pressed the wrong button in vim and it accidentally jumbled
> the code?
> 
>     1153         }
>     1154         if (cur_ops->init)
>     1155                 if (!cur_ops->init()) {
>     1156                         firsterr = -EUCLEAN;
>     1157                         goto unwind;
>     1158                 }

Excellent guess!!!  :-(

How about the following?

							Thanx, Paul

------------------------------------------------------------------------

commit a489ef720efa78763afa39fe88d09dbb4176a47d
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Oct 25 17:55:29 2024 -0700

    refscale: Undo j/J vim mistake in ref_scale_init()
    
    This commit gives each of three statements a line of their own.
    
    Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 7770e202d1ea1..7e6472a86dba8 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -1182,7 +1182,9 @@ ref_scale_init(void)
 		scale_type); pr_alert("rcu-scale types:"); for (i = 0;
 		i < ARRAY_SIZE(scale_ops); i++)
 			pr_cont(" %s", scale_ops[i]->name);
-		pr_cont("\n"); firsterr = -EINVAL; cur_ops = NULL;
+		pr_cont("\n");
+		firsterr = -EINVAL;
+		cur_ops = NULL;
 		goto unwind;
 	}
 	if (cur_ops->init)
