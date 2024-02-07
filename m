Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A7768E5
	for <rcu@vger.kernel.org>; Wed,  7 Feb 2024 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311059; cv=none; b=R4ho1vClu/eBe8PaYRQ6u1smbqdhs/E5eEUxsZaPka8TVTnuBc4Nw016dx9UT1g9vwk3y3pUBE2g2Lkj//xElOK40x9j9YKyYXvjBAsj6vHutNLFxD8HbmY/gXnmEkdiz64MY29dlyCLXJirjPgDQIamU3/D8KEadyFy3glSwDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311059; c=relaxed/simple;
	bh=pRzQfyhWUSouOA5dYpQb1XghYcG6E7IudMgJPUs5XZI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVKApQy4Fln9uuVw8m319zDAFH6TQMqWt0vUbgu7gFBhkc2lu7y1rKILcQ3eae2vDkQNnV7ZciufI2jWycYiKBvrYFOq2k43ztDgIefAFeH7BzWxa84aIXnRY8hnTR59CMMsesMgJKJ3oD4H2obsWehGhFiCCBcxpVGyEb3JmcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQAcglTi; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQAcglTi"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d0cd9c25baso2385541fa.2
        for <rcu@vger.kernel.org>; Wed, 07 Feb 2024 05:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707311056; x=1707915856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zXB1XW70EPJN5tXSLV9TADHy4fGL3w0gXS2n1Tqy4/k=;
        b=FQAcglTi3nxnwysvQu0uYJlX/6Ipb8UyNS73rU+seAs2J2nmDbgNu8a/DZIpEDSTIW
         nWKdcL1szYbxYVPe0JT9P9XtT5OEGcXkcLVAj+J1G3NUBFGS0xQoHBU4mBKPn6QugkmU
         Bm/rMy6VW17ZGx2lL4DgFX204ewEuUUyeTDa0ADAStRE8noqzZKl/5uBnp9b+L65U1C5
         i+IDwapcG/PrpOrqR+oah9iQZ8QyDxUHizmAsvWklBISPQLPGowc0v0cOEG2hHIX2PAx
         QfADty2EpN/Ga6zyj6dgNl93Jq1VoXSneRVnWJmwjP9umH3OxooT55oOuwOwLGkF50HR
         Iwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707311056; x=1707915856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXB1XW70EPJN5tXSLV9TADHy4fGL3w0gXS2n1Tqy4/k=;
        b=N6J/l8hHM2B4j5TFvmVPYtW6IGyxgQDRXruVPHKdhhRiXNgTkjIDUOaBbFrYtxsg/g
         jZ18U7SoHYS1rZazzDcPDakxASBlSFYB4OJoshrNlWglmr6M5K0J8rD6Xhw2L2NQrzFt
         p5T4taICkpl2LR40WmL2afSAaehU9nuj5Nf+W7fDlEY/89mM2SAMzyyOqHg6+n6bYALe
         NVlBFZ+4s04hhOnGWExjzPLAnb9h6VD/CS19p9KaJy6E/DJNDT5Iolg3k7VHyUHwhd7z
         0cZ+0GhG9RsPvBSEhSBFvefTry6dNPHJZGTUNGBGTSqhl0uw+zrkBJnS4aqsMbTykpcI
         eaZA==
X-Forwarded-Encrypted: i=1; AJvYcCVOwCHcrSndMerNwoNbuyCudAsD1hTgIcNL+TtCX/bJJDyMFmLoMzQnv65fTBHPvBbASmuKqZIXNkge435DXVPq1uq0
X-Gm-Message-State: AOJu0YzBxXh8TqI0i65+fcpK5rCPsJZN3VitBleumV4rm9Z1R/pKtLKF
	9un5X/Evi467WBW0LP/E/8Gub7P6WXhnbDJgCzICB5hHP+olRwo3ALnu8qwH
X-Google-Smtp-Source: AGHT+IFaTiCxrs7F44d8efFUFU5HDwRunlTbt56evDyb3e5kJUOEcGJHrvn+NFOscz5pCryD0mAjJw==
X-Received: by 2002:a2e:9098:0:b0:2d0:996e:b014 with SMTP id l24-20020a2e9098000000b002d0996eb014mr3879417ljg.32.1707311055310;
        Wed, 07 Feb 2024 05:04:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXyi/E4LAf2zIg6YxFsovkrC8ecgkG0hO6rQ7/c+rezAE/BUjxBHVfptg+QITqoaC2yEVpCRpLmhvGMnR40Bcaxoko+jOwA/xIORxmPPxI+MweAQzYDRPsw88LytJHJEFVqwaBgAVqJChwsLctpO0KcYHNDGgU9gUYlyuRXXAHAYH5/vnbPLaQnSKmmqgdjGvSLy4eK
Received: from pc636 (host-90-233-221-0.mobileonline.telia.com. [90.233.221.0])
        by smtp.gmail.com with ESMTPSA id 15-20020a2eb94f000000b002d0c1c0e8f0sm172328ljs.33.2024.02.07.05.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:04:14 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 7 Feb 2024 14:04:12 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Andrea Righi <andrea.righi@canonical.com>
Cc: Andrea Righi <andrea.righi@canonical.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <ZcN_zDNXRbbWN_Jc@pc636>
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
 <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
 <ZbieCjYk8cIgZS8L@gpd>
 <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>
 <ZbjYSXhIrVyCpRNM@pc636>
 <ZbjdL04k2Z2ZdUyp@gpd>
 <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop>
 <ZcJxhoNpkTM7LnOr@gpd>
 <92cba6df-01de-4daa-a0cb-5fa92c7374dd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92cba6df-01de-4daa-a0cb-5fa92c7374dd@paulmck-laptop>

> > 
> > I repeated some tests in a more isolated environment and posted the
> > results here:
> > https://discourse.ubuntu.com/t/enable-low-latency-features-in-the-generic-ubuntu-kernel-for-24-04/42255
> > 
> > Highlights:
> > 
> >  - stress-ng --matrix seems quite unpredictable to be used a benchmarks
> >    in this scenario (the bogo-ops/s are very susceptible to any kind of
> >    interference, so even if in the long runs NO_HZ_FULL still seems to
> >    provide some benefits looking at the average, we also need to
> >    consider that there might be a significant error in the measurements,
> >    standard deviation was pretty high)
> > 
> >  - fio doing short writes (in page cache) seems to perform like 2x
> >    better in terms of iops with nohz_full, respect to the other cases
> >    and it performs 2x slower with large IO writes (not sure why... need
> >    to investigate more)
> > 
> >  - with lazy RCU enabled hrtimer_interrupt() takes like 2x more to
> >    return, respect to the other cases (is this expected?)
> 
> This last is surprising at first glance, but I could be missing
> something.  Joel, Uladzislau, thoughts?
> 
Could you please share the steps how you run "fio" tests?

--
Uladzislau Rezki
