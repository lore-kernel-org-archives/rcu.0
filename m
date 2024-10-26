Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE581D363B
	for <rcu@vger.kernel.org>; Sat, 26 Oct 2024 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729948342; cv=none; b=bIAutADc6gc/7WUgEeNY45b1/Va4Gz/qbrO6ZfPjITLOEE7TIfHaZLZWE8InmHivSfSvaUH9Qi3wSsb2TgvPHuf4KtlpZJaXcSBFWqjKTEUha0y7teUctYmScWNX5N9Gy/XayKrWx0FCxZWfimZSgTXKx9pysHe5E0TbFxDWruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729948342; c=relaxed/simple;
	bh=OFgOwsIpZkzQ2gjthnjC5JWuTpz43edgKC9/3iYza1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBtLbeTPoTQX+cFUX7rbJrr4nVnaaItc1jCzW8Y/Woqd0wrVkaUBZah0jNv2oh1Oqm2zqMKIYUo/sZxpOdPgc41Qa+nAb843KDSyztvYBJLJRVj9i5ngUwVEgmjxuJxsukZkLRP2jfr7NvFR2gOskTe+seyS7UXgNrwUfN9qdyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umjFwID4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umjFwID4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DDEC4CEC6;
	Sat, 26 Oct 2024 13:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729948341;
	bh=OFgOwsIpZkzQ2gjthnjC5JWuTpz43edgKC9/3iYza1U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=umjFwID4l9mWSkeo996hnwTvVi1mGcrrgVdBv0dVz0rGBuMejZ5hkOk7frpB7KAO2
	 2QaToATCPD/kTmfD7WwS482wVapELKdBT/zJwXdohw3RG2u/ijyC3xkVZsSGSo9aFV
	 CSRcwxfNa0SR3Oq1GTw5Fe9WEpYGfnqmoYKPhYwq7Cv4Hpmiq9vEIED/avbTU3p5nZ
	 P6qXT/jgo3lL3VqU2h8wCvI3D1qzegmusA4p3x/mB633jbaQ6FMzva5Fsr6Ws/UV4r
	 qhyjoF1P9MUCKEgropkkHd5hpDPYyvH99xqYezSMuOao8ts4pEwrX/ZhMFuOgA2tym
	 POL3ywZO9DK+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 80321CE09EB; Sat, 26 Oct 2024 06:12:21 -0700 (PDT)
Date: Sat, 26 Oct 2024 06:12:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: rcu@vger.kernel.org
Subject: Re: [bug report] refscale: Add srcu_read_lock_lite() support using
 "srcu-lite"
Message-ID: <c8d5c0ad-9061-4e85-bd84-c5f8706d148a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <663547f8-3126-453d-8f9e-f9ce252d43c2@stanley.mountain>
 <08a3a25e-0c83-41c1-ba07-db3e2c9ccf19@paulmck-laptop>
 <5b5e9db9-5253-4600-acf4-8cc8a5825030@stanley.mountain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b5e9db9-5253-4600-acf4-8cc8a5825030@stanley.mountain>

On Sat, Oct 26, 2024 at 11:07:27AM +0300, Dan Carpenter wrote:
> On Fri, Oct 25, 2024 at 06:04:45PM -0700, Paul E. McKenney wrote:
> > On Fri, Oct 25, 2024 at 09:58:05AM +0300, Dan Carpenter wrote:
> > > Hello Paul E. McKenney,
> > > 
> > > Commit 1e07186d7377 ("refscale: Add srcu_read_lock_lite() support
> > > using "srcu-lite"") from Oct 15, 2024 (linux-next), leads to the
> > > following Smatch static checker warning:
> > > 
> > > 	kernel/rcu/refscale.c:1151 ref_scale_init()
> > > 	warn: inconsistent indenting
> > > 
> > > kernel/rcu/refscale.c
> > >     1141         for (i = 0; i < ARRAY_SIZE(scale_ops); i++) {
> > >     1142                 cur_ops = scale_ops[i]; if (strcmp(scale_type,
> > >     1143                 cur_ops->name) == 0)
> > >     1144                         break;
> > >     1145         }
> > >     1146         if (i == ARRAY_SIZE(scale_ops)) {
> > >     1147                 pr_alert("rcu-scale: invalid scale type: \"%s\"\n",
> > >     1148                 scale_type); pr_alert("rcu-scale types:"); for (i = 0;
> > >     1149                 i < ARRAY_SIZE(scale_ops); i++)
> > >     1150                         pr_cont(" %s", scale_ops[i]->name);
> > > --> 1151                 pr_cont("\n"); firsterr = -EINVAL; cur_ops = NULL;
> > >     1152                 goto unwind;
> > > 
> > > This looks like you pressed the wrong button in vim and it accidentally jumbled
> > > the code?
> > > 
> > >     1153         }
> > >     1154         if (cur_ops->init)
> > >     1155                 if (!cur_ops->init()) {
> > >     1156                         firsterr = -EUCLEAN;
> > >     1157                         goto unwind;
> > >     1158                 }
> > 
> > Excellent guess!!!  :-(
> > 
> > How about the following?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit a489ef720efa78763afa39fe88d09dbb4176a47d
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Fri Oct 25 17:55:29 2024 -0700
> > 
> >     refscale: Undo j/J vim mistake in ref_scale_init()
> >     
> >     This commit gives each of three statements a line of their own.
> >     
> >     Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> > index 7770e202d1ea1..7e6472a86dba8 100644
> > --- a/kernel/rcu/refscale.c
> > +++ b/kernel/rcu/refscale.c
> > @@ -1182,7 +1182,9 @@ ref_scale_init(void)
> >  		scale_type); pr_alert("rcu-scale types:"); for (i = 0;
>                                                            ^^^^^^^^^^^
> This for statement is messed up still.  :(

And also a nearby "if" statement (finally looking at the offending
commit).  With the addition of the patch shown below, are there any more?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 7e6472a86dba8..1b47376acdc40 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -1173,14 +1173,14 @@ ref_scale_init(void)
 		return -EBUSY;
 
 	for (i = 0; i < ARRAY_SIZE(scale_ops); i++) {
-		cur_ops = scale_ops[i]; if (strcmp(scale_type,
-		cur_ops->name) == 0)
+		cur_ops = scale_ops[i];
+		if (strcmp(scale_type, cur_ops->name) == 0)
 			break;
 	}
 	if (i == ARRAY_SIZE(scale_ops)) {
-		pr_alert("rcu-scale: invalid scale type: \"%s\"\n",
-		scale_type); pr_alert("rcu-scale types:"); for (i = 0;
-		i < ARRAY_SIZE(scale_ops); i++)
+		pr_alert("rcu-scale: invalid scale type: \"%s\"\n", scale_type);
+		pr_alert("rcu-scale types:");
+		for (i = 0; i < ARRAY_SIZE(scale_ops); i++)
 			pr_cont(" %s", scale_ops[i]->name);
 		pr_cont("\n");
 		firsterr = -EINVAL;
