Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653A1DFE36;
	Wed, 19 Feb 2025 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971390; cv=none; b=BauvE0g+U9iuuX4fuPfNjVCgcbt5ecAtOLLLMyZGHA9QFwwj1+AM47qrxU+VMEGJPvV88/CG2MeqK+LLSvShasN3AoJHkXlCfJlovG1ulrYMOOa9HnLdciIByuZnbev+4dHSn1hdOvoMdXHTPMbxga3u1yPBSDiSX7Kq4XL7T3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971390; c=relaxed/simple;
	bh=OmbSQ7U0peduJh3r3jFJoyuw/CtBTXPAKCPryIqGvR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tgpbr+etFmBNKoWjGKcecsnu3nVoboPUucYzAPvAP00kzC31LzKn4Af/VBI8lNYLFV1xT67qPeddcu69fEBPI337Se40m9Rd51oGLXtG2OPoIsbLSLCFY1QyWld3Z2TzaYVyiVa7IVhEOjPVcOcTVZVEXxL+nV0RIh31ARRC2F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT/nYvp3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT/nYvp3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB78FC4CED1;
	Wed, 19 Feb 2025 13:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739971388;
	bh=OmbSQ7U0peduJh3r3jFJoyuw/CtBTXPAKCPryIqGvR4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kT/nYvp3BpvSbPjONm6vrRwgjgiWfL2qOPEloeEjvDDspVviuOuNHd42SxGYTKgoZ
	 UiydyU5RMkeAVRxQAxmryDfIZ+xKrnmQ+pLZeSd2qOtlwjhPYLQVzABlzwj8WStu5n
	 G9cn5TtYlVCvX067BQhgrODdYX/1qDeG1QfBCEQsEDpv58U2HWi3srwdPtVn4Juljz
	 dm4juXRXJ89s1Pvdd3UQQqKJr0rdVJUG76Q2ZytRBaOAb0Hi0hhPkawnm7z5ZOnBh/
	 FWq1nEwGdG8aMskAvSGisqx4p93eel5me4FB/MQDz4vyvV7teReHYhA+gMk6TqDZc/
	 frnklcw5OQwNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 91D10CE092C; Wed, 19 Feb 2025 05:23:08 -0800 (PST)
Date: Wed, 19 Feb 2025 05:23:08 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, boqun.feng@gmail.com, rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH] MAINTAINERS: Update Joel's email address
Message-ID: <49abc218-cad3-4913-a729-82e5aa78a0cd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250219125425.1175676-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219125425.1175676-1-joelagnelf@nvidia.com>

On Wed, Feb 19, 2025 at 07:54:24AM -0500, Joel Fernandes wrote:
> Update MAINTAINERS file to reflect changes to Joel's email address for
> upstream work.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

For RCU and LKMM:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6ff7ba6cc270..97aba6b60158 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1608,7 +1608,7 @@ M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:	Arve Hjønnevåg <arve@android.com>
>  M:	Todd Kjos <tkjos@android.com>
>  M:	Martijn Coenen <maco@android.com>
> -M:	Joel Fernandes <joel@joelfernandes.org>
> +M:	Joel Fernandes <joelagnelf@nvidia.com>
>  M:	Christian Brauner <christian@brauner.io>
>  M:	Carlos Llamas <cmllamas@google.com>
>  M:	Suren Baghdasaryan <surenb@google.com>
> @@ -13296,7 +13296,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
>  M:	"Paul E. McKenney" <paulmck@kernel.org>
>  R:	Akira Yokosawa <akiyks@gmail.com>
>  R:	Daniel Lustig <dlustig@nvidia.com>
> -R:	Joel Fernandes <joel@joelfernandes.org>
> +R:	Joel Fernandes <joelagnelf@nvidia.com>
>  L:	linux-kernel@vger.kernel.org
>  L:	linux-arch@vger.kernel.org
>  L:	lkmm@lists.linux.dev
> @@ -19671,7 +19671,7 @@ READ-COPY UPDATE (RCU)
>  M:	"Paul E. McKenney" <paulmck@kernel.org>
>  M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
>  M:	Neeraj Upadhyay <neeraj.upadhyay@kernel.org> (kernel/rcu/tasks.h)
> -M:	Joel Fernandes <joel@joelfernandes.org>
> +M:	Joel Fernandes <joelagnelf@nvidia.com>
>  M:	Josh Triplett <josh@joshtriplett.org>
>  M:	Boqun Feng <boqun.feng@gmail.com>
>  M:	Uladzislau Rezki <urezki@gmail.com>
> -- 
> 2.34.1
> 
