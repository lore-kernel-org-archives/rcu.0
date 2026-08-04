Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06623EB0E8;
	Tue,  4 Aug 2026 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830675; cv=none; b=PQUAyHkaD4vOv/yMzkQufM0SKKl9JQFlZ9qtXCMTjkziPGGmf7UUqzliKBtT5WMGyAzHZKUFnUV6KBxKIgo4XQCKImto09gmNz6dkWurubpNh4MHwTEJM3Av3Dyt1bXb1o1Oh43D/PxqMbHbY6TcxEv5fq6E8+I3eLqt1A2u6Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830675; c=relaxed/simple;
	bh=8q2pC4RSAsfrLpDxvtn5lLAFPvvSfHn/Aa/cydtSPt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGf63WPqGLbO55gxE2hOOsqQpwmfYt94bsTNZnnqNtCERbYOW5QSwdGgznnWjPr50PBmiq8Pu7R/zVzsJ3o/rE/BQNtBwEU3vpm34NiHqg57khweYsk6AD5jJ067T4vha8FghwdVKC4gVyoJg8oNMhTTwdU40oqluw8nK8udCvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IZOSLF/2; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="IZOSLF/2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5QiyqUWd79/j9Fie9dsCM0u/y75VmqwoDDD0eNMwT8s=; b=IZOSLF/2uzMB+Fgvihw3t74aBz
	USSTIjDJxwnQg1CCJMW1WDs6bTy9o/C/o6GV3C98UmmaH6RayRjdSwtRCYUNVkkGmdG6lb6fFlUvu
	8iEm3H2oJdUJrYXgI6KCjJ+fvXa9FjYDx2R41IZsQgvnQwiPJr9cyfLsVP49MFqnqP8D7EPbd8hQs
	la1jmpgZjNQyBywHqdvvhfQoJYah0qetDmLEOT/nQQz9luQoOsMqXtfvIllGyCT7rePCh3grQ3s/s
	d84THoCBcpwuiigi3b38HPpDQFNbLKIXTZVW1gtVx5yjQJvXok53oePyTSBDRzXMyxguf0Fj8BOiv
	GFGioQ0g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wrA8S-00Czyv-1B;
	Tue, 04 Aug 2026 08:04:28 +0000
Date: Tue, 4 Aug 2026 01:04:23 -0700
From: Breno Leitao <leitao@debian.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joelagnelf@nvidia.com, urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Queue sdp->work when the delay timer is
 successfully deleted
Message-ID: <anGc7qa8fzrDf7dp@gmail.com>
References: <20260709100602.821-1-qiang.zhang@linux.dev>
 <amzfBSSGyVF0vyQ9@gmail.com>
 <0bba3fa18b116a3b08e3e83310b3197bcf780000@linux.dev>
 <anBxXePfyHY2Uz0d@gmail.com>
 <68038c37bd588be7df2892e85ec9bab31d20cd34@linux.dev>
 <e3738457818909e56c8aa5aef99d8b3e26a328d3@linux.dev>
 <96d6edfce3ac43e153a21b23994251ede0fbd7f4@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96d6edfce3ac43e153a21b23994251ede0fbd7f4@linux.dev>
X-Debian-User: leitao

On Mon, Aug 03, 2026 at 11:40:14PM +0000, Zqiang wrote:
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index b9fe57ff9100..d13c12f61150 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -751,8 +751,9 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
> 
>                 // Call srcu_barrier() before this cleanup_srcu_struct()
>                 // to avoid triggering this WARN_ON().
> -               if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
> -                                       rcu_cpu_beenfullyonline(sdp->cpu))
> +               if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
> +                       rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
> +                               rcu_cpu_beenfullyonline(sdp->cpu))

Isn't the WARN_ON() the same? thus it will hit again?
