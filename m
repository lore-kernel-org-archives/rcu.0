Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B179533E37A
	for <rcu@vger.kernel.org>; Mon,  4 May 2026 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929080; cv=pass; b=n/dO4dEPnSb2tt2xLxZpP3eylb+qZqvTFHZz92Sgk9T7MBbneQ7fBFk5/+8mYZWaDCiXBHHVcvGOBFEHOp+4tV4FnF7UT7eE+HxMAMTKqFZ6UejGTn8nFsq+hR4h9mHPvsivUvw/ebHP8L2BXYybUkqAQyL5uiBkdSLXnYRrtvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929080; c=relaxed/simple;
	bh=9txmbUlOtLyVx1Jle8W9GnIPJ7Z5HSJUHdzV0nziBkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsP95d0dg66mht23IESWr30gVTxpDyYgkMGQmOrkdm8Rxl4DDuobXPIcEShFoHyIRVJ6qFwBtsLL6b25SwX8WnUJLZoCDQjK8CtwtFj6kQraGasxwK1UGJW05tYUzdEDXprUK9JOy8QZaaaShSS0c7F3Kc6ILAK99GISFQzmTPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fHYX1OsG; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHYX1OsG"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12e332315a8so6144790c88.0
        for <rcu@vger.kernel.org>; Mon, 04 May 2026 14:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777929078; cv=none;
        d=google.com; s=arc-20240605;
        b=Tr5lkb/1O28DM1Q95aiM+12F0PFLdOfpFd5q9OXb8y0YSi8XjFWW10jsdKLOT96vR2
         1vQ9OkJ7BJkz3wJZMuAGOg18eGslzAJzL5igJWRo6DoMjjUNdZ9x6ftYQ5nRjoobYNPK
         oAyLFEremVhUvOtvDZPbUUYzc7JJE0qYj2Y8QQtJVXCj8T2i4s3pCj39jGccil9XPf+f
         znjla8RGe440mLaaTQC3VyhuL++OBth5UlWEqqQBJt83sjEgehDQ2FR6Q/m/WE4/MYsh
         akM22eRqzjZKMTsy9aVRcs9yZ78V1kYmDrptzlRTuxr0q9dgbrwRBGBpFC6F81vhCVqa
         uh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7DRVy9SsaAYT6OesKtlsYJKb26JJrF+IGUxhDyvQ9/0=;
        fh=U3uMdB1N1Fl/1kvOL9U/yBAwyY1sXPY98L0ZvaNcB+I=;
        b=O7gKABuuYM+0gbpF+8vPg3brWRWkpiMPy7mtCanJ4mAY/uzqZhuz2Hxepg7NKQIbjU
         1g9SS7w7r/DhNdseD1v2Ia4Plr/j8R9FjVIKegR99rY/rFEmq0MHkDQW512wR26yExNp
         hLFsrTUdwZnjHKcZbwaLgsAVdd9Bq/bl9Ttsgm2ZekJ9wlLsCvEzOm5ye98MITzjJNu3
         KO9YZmp6uxbVQqwsJsU96X3Jjh+NK3Al3hy0rPV3Ufh6kURvmjK1iHEG4E1V5dqgk2iY
         t8M1ACUAbKmuz/nMADatDaOZ9k63IVtbhA0kgEM5PPQDDu66ys3zTcyo6DzxVfajBBP0
         uszA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929078; x=1778533878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7DRVy9SsaAYT6OesKtlsYJKb26JJrF+IGUxhDyvQ9/0=;
        b=fHYX1OsGS0ZFOeE5zYnHxJD44meYr3HWEQXwSHTIilznepz+h0cgsxgSOto9HvsGny
         f7xIZcLHQUi/CKF4lR1D2wo/sZ6U0O+t/9fjkoA9Gcq+s7cgVzSo0AanJ4OwUuJd2Lxh
         djqJ/Bb46U0/ldVHO03fR+N9KZ2bEK1EkMRiMYZGb8vUuSOjIgRmjX+EQK/iXVWcuzDA
         9lq1Bag2s4RM38VFK9wi0s9l+fjheXOwcwYnpCcppIJBDBg0DxGfmiw4xU/ZmDdenc4G
         3tgBymUNkplSCrGziYgYvSXVrheCnivMG7dgw0X4993vmK+ZY2sewPP/89cSiSGhy3YO
         BqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929078; x=1778533878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DRVy9SsaAYT6OesKtlsYJKb26JJrF+IGUxhDyvQ9/0=;
        b=AennJyqNSgLhOqc4/2NVY7yhK86xCbw6fDB4LBnDpo2Tcw1+UftpcfpR/5UrzWu6e/
         oRxApRmnLOAb2ALiz0+CU8okPoBwJHYroiPxwBjfnk+Yv1wF81kB6oxweSq6lwEh6hz3
         p5x6mKRvU+OKQmxzsOKnDMXGw3MGHK98Q9z2v2LDL0mTW+iKJdcMCoMOcLTt5XfQBhQB
         EyA9h9xie0rxzP9gs1wxs9djlraoPqzOXgcXZu1w6G0OFnPWT4XxgO6qysapkgqm74qS
         gJ/0qVgS4NuiGp9XSZLs0KMGZhI3kG7hQ51MCZdCa2Xoc9iG2LfsJib7UgzJ8s2pxNhO
         unsA==
X-Forwarded-Encrypted: i=1; AFNElJ95arLySPd4FGiIsbdvCIJDKMiGmdZ9j0lJ5uvKve7xA0A5uyCJlDXNIeELt6uD5sxTJVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyepwl8Tm39NgK2uJotTAesgJJOvwe/julFdsHj12Gwz0C/v7qH
	zWWYiukeaUzsitNC2EkJTUNnXG0BTDtCzpRZpfxo1qMOcN33xYhcmEws3XJy6x3soTkvL4cswqX
	SB3F6yfeK4BEFkdw3Q695HpwM3EU05xGYRCAUyXUZbVPiWPOA5DR1GeVm
X-Gm-Gg: AeBDievZ3VHdSkIrfUtPoQmc/r+xTnxIesjwBudD8Dqst/NRHIRlRES7LupI2up+PbR
	o8Kj7RhiyVSk88mOqdeaIPYf2+JrdWa9lqcU44Zq7kjgfBOHXBVcAr2EoSsgEBh8PpeRbtJHbg7
	OGEXGWOZJiHbjGZkhJbd4Zv8m79JwkAlV0rEOeFLUVqnawDIK+AwcqJ4CrytV8aUmb6nNH3a//w
	ScqxODO3XN736Oer3WzIRr3gl/GpdTVufXztcwZWImr7yZZsd/zalSlalJbo88iNsPk8YOwvhVL
	JygYYP6KJaG+3i+f1u7PWbQuvQglgWTjETX3G7hfDEfnMGQj9GujOH8CjB5Y5Vm93jw6oQk=
X-Received: by 2002:a05:7022:f688:b0:12d:de3e:52c0 with SMTP id
 a92af1059eb24-12dfd841184mr5921612c88.36.1777929077311; Mon, 04 May 2026
 14:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502015733.431424-1-bvanassche@acm.org>
In-Reply-To: <20260502015733.431424-1-bvanassche@acm.org>
From: Marco Elver <elver@google.com>
Date: Mon, 4 May 2026 23:10:40 +0200
X-Gm-Features: AVHnY4Id4CL9kY0mJyf22QnGq7VBCzHZVYfMmR3NAmXQzqOxf7hPqjQN5NlUMaM
Message-ID: <CANpmjNM42r9aY3Tz-LYW1KD1Uvak21na0PpY97w_iyuYrTfv=w@mail.gmail.com>
Subject: Re: [PATCH] srcu: Remove check from srcu_dereference_check()
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 May 2026 at 03:57, Bart Van Assche <bvanassche@acm.org> wrote:
>
> Users of srcu_dereference_check() must hold either an SRCU reader lock
> or hold the update-side lock. __srcu_read_lock_must_hold() checks
> whether the SRCU reader lock is held. Since that check is too strict,
> remove it.
>
> Fixes: f0b7ce22d718 ("srcu: Support Clang's context analysis")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Fair enough:

Acked-by: Marco Elver <elver@google.com>

> ---
>  include/linux/srcu.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 81b1938512d5..51864281164b 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -235,7 +235,6 @@ static inline void __srcu_read_lock_must_hold(const struct srcu_struct *ssp) __m
>   */
>  #define srcu_dereference_check(p, ssp, c)                                      \
>  ({                                                                             \
> -       __srcu_read_lock_must_hold(ssp);                                        \
>         __acquire_shared_ctx_lock(RCU);                                 \
>         __auto_type __v = __rcu_dereference_check((p), __UNIQUE_ID(rcu),        \
>                                 (c) || srcu_read_lock_held(ssp), __rcu);        \
