Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A34233943
	for <rcu@vger.kernel.org>; Wed, 14 Oct 2026 03:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948530; cv=pass; b=eu5hfG6ylvgbXarLv0UCcmp5m+phCGfCP0ZNZmvPOLH4/WrUIggccje4IpNZor7mPEfyygMPzMjiKiqxD46iuoWR48Vsj8ZJjqxTEHTe/j4ifr4NDk6/FCgDJZAXxYkA2fXkJJ28wLzcEX5arDTfETUnnble87xFT4XI5loEVBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948530; c=relaxed/simple;
	bh=uu2BgegW6iIK5zC2oRBUHQ5g8vV1itfviPQErYL/pDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLlgUNp2j4jm8pk/lXithkPwVQzRKiBuq3URS3oRAE6q2aR+mbHdCKCfA6XSGU7nckERNFBEZ0M6vMASDNXmOOKP/IyPmyjIqYk/QEQyhyeDwTAQXm110DHZCGZHHw2j5jkTEDSpwgnY7WFl35ur52ch4/mXanDWkSTLelLlyZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdHUzIEu; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdHUzIEu"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so5545571a12.2
        for <rcu@vger.kernel.org>; Tue, 13 Oct 2026 20:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791948528; cv=none;
        d=google.com; s=arc-20260327;
        b=K4j+gxJBg421UzImjCyIP1KcgAL1uCsN1VYbRoY7LBtdVQ2b+wQyikb7lR1sWuVUXS
         bmX+HxqHK0AmymvyOXP0WgblsN8CNfswnQLM+bDTPt7dEal8o0gS6mJBHHKjsbB8NxPK
         mfGWQZ4svYSDWlIykOtkQmQdwiK4PmzTvJPCWGjk47fRvqg50XaiS5PZ0waxpxfThEte
         bk15OQDz8K+l3A8thrFaerkWPF477aMqzpu8o8l8FFH7uVd7cWa1nqpq0ppABZIVsmnk
         IxvNlP/zdaWtKurZMf8YsNOE+5I5l1V9DlNZ8fPr+5Qj8QXRgA1Wljd0etPi630I9gON
         S23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HnAtWY3LwsXAyH/LIq5+W3HHx9lo3GsZAUzviRy9PaI=;
        fh=Un8R8LIZU/JoiG5jLhnfBG8xef8C8AktJifjH5AbtdQ=;
        b=sHostPOmY1eNzffDm2W/hV3J1IKj32utfkAroaShZx9rafWzaWgexFVbNMb+2FaFI1
         nx43bhvVjNVF0Jg0CVYX+NRB76kB4tV4jwqJy2Fwe8nlCNviF8OwZMKh0zlV21S2lsTV
         BICywPEiypv6KcqSpSM2O1kDypqoqGRRQiSxS7AFBwNatfaS528YHyDTvUq5Y85TyHU0
         hLyVojL/dn2oqwEhMeFbUbmJfRLmxjrtu/eIcOmlTyLkJMxqxp7eORSEQ8yMGbZOCK0U
         JxR58FAK5RuXWZ37oJ3wCRrWda3wHWNRj63ZQaQHR8CF5Dc94jj2nealoPNVFUt+94b9
         ks2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791948528; x=1792553328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HnAtWY3LwsXAyH/LIq5+W3HHx9lo3GsZAUzviRy9PaI=;
        b=gdHUzIEuyXyBaXFjVe17M4i4Iydm5v+SsGEl/RloS23Zjf/WIaNMyo0ATOXbKHa7sS
         OyZL/iTw6og+Yu+v839i0c9Al6uBoIB1LiX9sNEB+0Bb1O0NsYMul64UB49E9DG8UA6l
         cdtTmIaVRNHrdhwZ5UV4Q4cwR2yXbbWPK9BOdCH78OzUd1CEOS1OVqiZgWasRxnbdfyf
         rUFam7uNhE3V0/HXdsBHDX6FQBWHr3KnlspQO1JrCoM4Lr1ZM2dsQodPLmjPqyFFnPh+
         GzDyz+Z0lKEO1TQ2wN4geg/3ySMSuJoVC9O7b0oHvCoGwBfKcbx+7jEgN550I2MhYgZe
         QaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791948528; x=1792553328;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HnAtWY3LwsXAyH/LIq5+W3HHx9lo3GsZAUzviRy9PaI=;
        b=TO/P9CNY0/pItkvs21avzuNx/XyLITacZdVyoR8udPBw+gM+uLpJd+cZKsFkOe6Y9n
         EpmAtkbeF1H8+WGpPMx0O3z+0aWIvabtiq9lYnT1Cwao5xyt4fhJ60TQ11k+59MH+WbR
         Z+WBYR+Wy20y9hpuOMJTLn05tCuELmjsNSluCMcbSELBwwMuyMHcXdXdtAPlaYcpo5Ve
         dn4b+13APZUsVOuH7fWcvZcBNJcX0C7CIrHcn2JZRvn7QuzMMF730cvyylOMURZyuLW3
         SsCR+B201deIodtI150cVdXQqxAW4qlTYMtnyaWRLE/lF2cN65xlcqI8VtBTtMex3paG
         YDyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxyZOLn7rz7MOlgvKvul2lOtALqTNX4DvOl5IiOX2tkF6dKtdmNcINk5/TxnX9kM5SUDKs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKd9yN+Dl2yJEmMl/0zfnHPP/RoxBW+0NnXfp58OkCiXMR8uzr9
	MRkXDeJFcX75oFN5WJ4Kc05k8UXoZV3kQkQbd9MOCpM+qWQVqaT69nEoQ+cMeA9SaCpfjRVRP8J
	6SCdiQjXIJO+3gO16tenGZ2u626g+UGM=
X-Gm-Gg: AYBFou1rkhVWrtXxPhEnQn+vjPQifimWHQQrarlK++TaHfmnVKU9PyrxJCidCp30imx
	ks3QHie1DmYnvSFio7F0uAKEOvzP3e0MnNSbBWeUvF0mfz4Mk1dqyeaNv/YHalK0fltJsZTPt2l
	hp5mGUNOENO95H/6ElfHDRPKW9SvQX+w74Jn+814IG54Zktn98PTR18T9VEQGoyOedS/6N3PzZh
	bIdYeCTyNENbn0zZ0idmubygWZ/ZsOR6szowzePoW5TjsZ9ENgUeqdpjZzD4yEdv1uggX5jk4A7
	2Ym8wYXrzR5hR9WeRR51ACNR256gQ0fJ2R6IiJ2NCYQy5ZIKmoKYTK9m
X-Received: by 2002:a05:6402:3241:b0:6b1:c355:c7aa with SMTP id
 4fb4d7f45d1cf-6b1c355ce43mr4215020a12.0.1791948527663; Tue, 13 Oct 2026
 20:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010102813.25460-1-qiang.zhang@linux.dev>
In-Reply-To: <20261010102813.25460-1-qiang.zhang@linux.dev>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 14 Oct 2026 11:28:36 +0800
X-Gm-Features: AclHuK-V8vTFUQbxf7lHlHszzHIzi2AYahgPeKaVtg8w781-TTWwAZSX2kI8ohU
Message-ID: <CAN_Opa9r3BiT+=gE-sR8A9xmAZfA0AKZ0M05_+JZ7hrcXWR6=w@mail.gmail.com>
Subject: Re: [PATCH] doc: Update recent SRCU API additions to whatisRCU.rst
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joelagnelf@nvidia.com, urezki@gmail.com, boqun@kernel.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kunwu Chan <chentao@kylinos.cn>

On Sat, Oct 10, 2026 at 6:28=E2=80=AFPM Zqiang <qiang.zhang@linux.dev> wrot=
e:
>
> The commit 'dab06d6f9379 ("srcutree: Add an atomic Tree SRCU")'
> introduces some new APIs:
>
> srcu_read_lock_atomic
> srcu_read_unlock_atomic
> synchronize_srcu_atomic
> DEFINE_SRCU_ATOMIC
> DEFINE_STATIC_SRCU_ATOMIC
> init_srcu_struct_atomic
>
> This commit therefore update thems to whatisRCU.rst.
>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> ---
>  Documentation/RCU/whatisRCU.rst | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRC=
U.rst
> index e6767baff2d3..75c50f2f6d79 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -1209,11 +1209,13 @@ SRCU::
>         srcu_read_lock_nmisafe          start_poll_synchronize_srcu
>         srcu_read_unlock_nmisafe        start_poll_synchronize_srcu_exped=
ited
>         srcu_read_lock_notrace          poll_state_synchronize_srcu
> -       srcu_read_unlock_notrace
> +       srcu_read_unlock_notrace        synchronize_srcu_atomic
>         srcu_down_read
>         srcu_up_read
>         srcu_down_read_fast
>         srcu_up_read_fast
> +       srcu_read_lock_atomic
> +       srcu_read_unlock_atomic
>         guard(srcu)()
>         scoped_guard(srcu)
>         srcu_read_lock_held
> @@ -1229,8 +1231,11 @@ SRCU: Initialization/cleanup/ordering::
>         DEFINE_STATIC_SRCU
>         DEFINE_SRCU_FAST        // for srcu_read_lock_fast() and friends
>         DEFINE_STATIC_SRCU_FAST // for srcu_read_lock_fast() and friends
> +       DEFINE_SRCU_ATOMIC
> +       DEFINE_STATIC_SRCU_ATOMIC
>         init_srcu_struct
>         init_srcu_struct_fast
> +       init_srcu_struct_atomic
>         cleanup_srcu_struct
>         smp_mb__after_srcu_read_unlock
>
> --
> 2.17.1
>
