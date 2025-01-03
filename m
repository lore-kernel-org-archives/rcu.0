Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6C155398
	for <rcu@vger.kernel.org>; Fri,  3 Jan 2025 05:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735883465; cv=none; b=ZR4XNY4X3+9bxrdjJ3bnQxQjpPp1S53SldTGfZuNZgp6YsTgCLoI3NE6q9zDuX0sIpHSGVGFOCC0QbNSVhV4WmeyRxdIstFYOtUSZHUQUNhOQUjpkwXBlvO1r40nhOV9ux8ExsE4QKWjX0lAKAW7MDxrSS2XgufwOpjxHRL/xK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735883465; c=relaxed/simple;
	bh=Mm+lec5RXWIPDEy57yr7yxjKCVX4xTD62HPDeHBwcxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CawGurnmEso6qCA0WNNKf9L/1zFofKwy/c05IB685EbJ7WoT1nrs4/UWZ+lm9PuayGhotoHjQtGXxcPEpNJk5lICqKPP2inZvpBE3QAnWC9NoBn+zn8M+WREAL6I0O0Qx9kKIiZrRV/BSzIgTbMvVaxVqEP9bRhxCR98LQJPboE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqR6t/us; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqR6t/us"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so16780850a91.1
        for <rcu@vger.kernel.org>; Thu, 02 Jan 2025 21:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735883463; x=1736488263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tnn6xbqJYAHuvqQnBfT5SECUCL45Ad/ih+424BscjdI=;
        b=MqR6t/usA27fFfQAeV8GhVeRPGj3QRqSer2BWh7MObTLV7FUpDVDiYqqL7yTyJLng1
         dCFtffzydv/eOcxoyhqk5kwHDEBSTYWJ9XqDNp/FQoO556qMVVv5/CHTPzRs9cpCCa1s
         Vl8xfzRKRZEMAPfwVFMYj/CdCwsaxZfewf8yEhyXNldg3ehIx9mYK9smOoAK57C/Si3s
         +ml8DoY3quXYTEvGNh9FBba6Om/oW5t6oN4jI5QKlKrrjO5ZR9rWfo7rhZ2HCqwt/7yR
         hQVllxHCkTyUk1Ew3yILaWwRzfYDRmNbC9msWj5Q8p9CJPd+12EMQIxSCr0/TGg8QkrR
         8B9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735883463; x=1736488263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tnn6xbqJYAHuvqQnBfT5SECUCL45Ad/ih+424BscjdI=;
        b=v6PwwN2YoyRFaHJ9b33ukVNRON5GeujZ3OC22U8mvi/P/pFhxjBb/+7LCUGpbzBucr
         m7oDtb57zaqj4FPzYqaE9klVnHDZKfIPNL+n6qVjfm93p9zyVsv8KvNas2hAFpDqWtGZ
         CLoFi24uXKbH7BTyymVGxLN8C26D0wZgLiPdCYlvWFTP9PSGzUtXRhrtnbKD/g+VY0B/
         F3NpyDiJaSybZ/gYflDUeMJkKt0cGHFyxrwVrhUqPC8ahzhzCFFNbcjxBV5OsYcNwPMR
         Xo03LtKE8iPrq9B1J/3s4KUxF7CeYE0AvTq9CNTGm0W+fBWt75x2m5070Uxz/IstFUXD
         qZuw==
X-Forwarded-Encrypted: i=1; AJvYcCUt4i8K1ozgek7Or+sDpAWGF1SNhUfaRjruxhJ0x+/IVLWl2Ndg/THgrDQZ2paQaI/USRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJftswJ+Rj4BG5k4A7D2c7A9mG37nBO5lNBuwUUdIMYbxUQF2k
	1MdEz9T8t77hQhkq3pxagBEQoc0gT55Mx70VAx3l7hdS5o0zwNqY9EGlpvcer4D0BRpZq6iAjgZ
	ts2XyD/IMr+FUZcGgtD0q9ZWveec=
X-Gm-Gg: ASbGnctGUjmB6j0lYv9dHwjwLGGp4+jJwcPDpfa9uestiUVHqZYLhdi8n3ungxfeY7t
	jJZXVnV75IcXcMq13FW7WxV5kXHN3Gu1dwPazApE=
X-Google-Smtp-Source: AGHT+IEmQnz0qg8jxBmk6+ns2wi4oSu6mST+8uO3XtZB0sreopxrxwo86w8tIgIgf95oYxq2aUIuJBGDuOyvKyxozHo=
X-Received: by 2002:a17:90b:2cc5:b0:2ee:aed6:9ec2 with SMTP id
 98e67ed59e1d1-2f452e16379mr71807444a91.14.1735883462558; Thu, 02 Jan 2025
 21:51:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202412311203.ca7bddba-lkp@intel.com> <CALm+0cWOxUm_hrNe4UP4Z-vyr4RCOw+dc=kCBTgsyjHFHiHDsg@mail.gmail.com>
 <949f6251-d411-45ef-9f85-d5d069b90b0e@paulmck-laptop> <Z3Ym/DDtGOPamGjZ@xsang-OptiPlex-9020>
 <c8c4c6d6-ad52-4cd2-ba1f-c442da4432af@paulmck-laptop>
In-Reply-To: <c8c4c6d6-ad52-4cd2-ba1f-c442da4432af@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Fri, 3 Jan 2025 13:50:50 +0800
Message-ID: <CALm+0cVbaJuMWMkU4g_6inCKiBVaVD3iixvBrfMJTqZ-3OUCvg@mail.gmail.com>
Subject: Re: [paulmckrcu:dev.2024.12.24a] [srcu] 9216c28c6a: BUG:unable_to_handle_page_fault_for_address
To: paulmck@kernel.org
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Thu, Jan 02, 2025 at 01:41:16PM +0800, Oliver Sang wrote:
> > hi, Zqiang, hi, Paul,
> >
> > On Tue, Dec 31, 2024 at 08:19:44AM -0800, Paul E. McKenney wrote:
> > > On Tue, Dec 31, 2024 at 03:16:25PM +0800, Z qiang wrote:
> >
> > [...]
> >
> > > > >
> > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > the same patch/commit), kindly add following tags
> > > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > | Closes: https://lore.kernel.org/oe-lkp/202412311203.ca7bddba-lkp@intel.com
> > > > >
> > > >
> > > > Please try the following modifications:
> >
> > yes, the following modifications fix the issues we found for 9216c28c6a. thanks!
> >
> > Tested-by: kernel test robot <oliver.sang@intel.com>
>
> Thank you, and I will apply this during my next rebase.
>
> Zqiang, unless you tell me otherwise, I will add your Co-developed-by
> and Signed-off-by.
>
> Either way, Happy Square New Year!

Thank you,  Happy New Year!  :)

Thanks
Zqiang

>
>                                                         Thanx, Paul
>
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index e85db7d5b364..7c7304dee645 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -1999,6 +1999,7 @@ static int srcu_module_coming(struct module *mod)
> > > >         for (i = 0; i < mod->num_srcu_structs; i++) {
> > > >                 ssp = *(sspp++);
> > > >                 ssp->sda = alloc_percpu(struct srcu_data);
> > > > +               ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
> > >
> > > This does look quite promising, so thank you for digging into this!!!
> > >
> > > Looking forward to seeing if it fixes the problem.  ;-)
> > >
> > >                                                     Thanx, Paul
> > >
> > > >                 if (WARN_ON_ONCE(!ssp->sda))
> > > >                         return -ENOMEM;
> > > >         }
> > > >
> > > >
> > > >
> > > > Thanks
> > > > Zqiang
