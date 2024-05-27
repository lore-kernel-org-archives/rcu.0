Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA815FA84
	for <rcu@vger.kernel.org>; Mon, 27 May 2024 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716842176; cv=none; b=IvxhCQMfk9VGJlFNpMVVV4UVOrBO4nc+FjdporZntkheAfPE5gopfFjjgX7YNPIm46Lh6rlvn31GmjWkKWIjdp67NMvWQHY8KurptrZn4nMA+r2/o3zqRlE617zv/aF6/zP7exJizHj2VDrJnqiG+07vp1nbyoDW0O+1Jeny9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716842176; c=relaxed/simple;
	bh=m8WOzOB9v7pNpgudUYWkL0MpGbZxm84uIXIMDUHNAck=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krXYiXo33cYTirCkcGVNFEX6/HtC4ODxHJXQfdYn4FHepDAyMBpImofcLyqhzg2Ek50rGElPz5AZC3znJ/FAvdAdSuB8Ti7cV+MwkoXhn1+FRHf84Q7qcpORZjPcC/kgF3Zn9Ss/9tY3U/kpw+QLjvqgSREwYjbLUW4xR1NVcdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i68c9k6O; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i68c9k6O"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-529b4011070so163479e87.1
        for <rcu@vger.kernel.org>; Mon, 27 May 2024 13:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716842173; x=1717446973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aOh10dbgxM2e8Aowe5HMEmqvNcOhtnTLTtTwACrVRLU=;
        b=i68c9k6OWdoydXQF/dvU0jTzxpYSX3tnpY6g/pnbUCNem+mBt1h+/SMDZnFWfSNiCk
         IExPiKVkXLnfIprWd4wiW0WehDUNdFpReIQX8fFqgqH26tVOxItMTBkvTMgz0XuG9Ie6
         ZYeLVGW1tU2xQXNp3PlL5PBOpCACGxJER6IunzgVHh6d5pWAbAFytYWP8INc/UyopZdO
         QkkHaloauTVFkBuw6x5cBX1y5bEycad8BUEBvi30bckuVn+ct/fCRN/lIrA+yZErMtjB
         f78cKNiGHMPEE2nlh+V6aKfH8AeS/6sqEtff5wu4HbIKLSUf2tsZ7OLo2CZ8BBy9f1fK
         HEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716842173; x=1717446973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOh10dbgxM2e8Aowe5HMEmqvNcOhtnTLTtTwACrVRLU=;
        b=HMkAoGUvHWIgupPeTyqmzx5yLeeR2gOvoWwhW/zXM3zEWDPMV467fHFPR2U/pr5LMj
         Klgy7R7k6AtlNsBsqVcTNT9zkih3uPLzoDtuAERne6EcrIym1QUNCmP8joQxSvuKPT22
         XnY7kjCTqnivSRv1g1clRYO8zmFHfcilRKlrG21cUhgo/8J/1JrLz6hCDFqSzW+fQJIU
         /9Srwcbu3bofglS0wiytbbU7rKmGspoCQGE6dRkN5dal0WMxY5k5tQhTLfnNE213sJWT
         mz2dDUmI/Pakxs0N9OnIOUZwDo+rBDXxiRyD/xnpWQG1Mmz0i9IwIYRb6iQPTvqkCnYf
         tduw==
X-Forwarded-Encrypted: i=1; AJvYcCUQUHCn/egy+uKI4LFQ0HKMy8Elr99xnzauFXfub3P8k4KviurcA4g8YGTQo9KYO/CVnjXPSIYMnPWGI5VKl+rf2Ama
X-Gm-Message-State: AOJu0Yyvu+3eftWTfWhnicML5F8ObEocXVEGDGvsW/JuYuBFtFP+cTex
	+JJCiu3+aWVD06XZbeeXg3udAmPah8hxtUaD492wQ7Ruc1DPRbte
X-Google-Smtp-Source: AGHT+IGB/FJQ/RZ2ky0gMGvUT0CEQmqqoXZyi4q2+DXHYIKGo5ql9EVgn7P7wWZjfxW1kRVtS1TDCw==
X-Received: by 2002:a19:f70b:0:b0:523:9493:432c with SMTP id 2adb3069b0e04-529666d6f30mr6497708e87.59.1716842172424;
        Mon, 27 May 2024 13:36:12 -0700 (PDT)
Received: from pc636 (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066bce1sm766062e87.169.2024.05.27.13.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 13:36:12 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 27 May 2024 22:36:10 +0200
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	RCU <rcu@vger.kernel.org>, cocci@inria.fr
Subject: Re: [cocci] patch idea: convert trivial call_rcu users to kfree_rcu
Message-ID: <ZlTuuquwqGIiki6Y@pc636>
References: <68b85796-c674-4691-936a-2051849f4692@suse.cz>
 <6b7e3ed9-d974-cb3b-6839-a6b7cf5f5a36@inria.fr>
 <a1f15e67-25f5-4a0b-a9d0-ebbc0555fb12@paulmck-laptop>
 <ZlTjIDrnPb25UTUn@pc636>
 <alpine.DEB.2.22.394.2405272151000.3330@hadrien>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2405272151000.3330@hadrien>

On Mon, May 27, 2024 at 09:51:35PM +0200, Julia Lawall wrote:
> 
> 
> On Mon, 27 May 2024, Uladzislau Rezki wrote:
> 
> > On Mon, May 27, 2024 at 12:27:14PM -0700, Paul E. McKenney wrote:
> > > On Mon, May 27, 2024 at 10:13:40AM +0200, Julia Lawall wrote:
> > > >
> > > >
> > > > On Mon, 27 May 2024, Vlastimil Babka wrote:
> > > >
> > > > > Hi,
> > > > >
> > > > > one bit from LSF/MM discussions is that there might be call_rcu users with a
> > > > > callback that only does a kmem_cache_free() to a specific cache. Since SLOB
> > > > > was removed, it's always ok to use kfree() and thus also kfree_rcu() on
> > > > > allocations from kmem_cache_alloc() in addition to kmalloc(). Thus, such
> > > > > call_rcu() users might be simplified to kfree_rcu(). I found some cases
> > > > > semi-manually, but I'd expect coccinelle could help here so if anyone wants
> > > > > to take this task, feel free to.
> > > >
> > > > Thanks for the suggestion!  I will try to look into it.
> > >
> > > Thank you both!
> > >
> > I wanted to take an action on it but Julia was first. So, please go ahead :)
> 
> If you want to try, please go ahead.  We can compare results.
> 
It is appreciated if you proceed. From my side i will keep an eye and if
n it. If something is missed, which i can detect, i will let you know.

Thanks.

--
Uladzislau Rezki
