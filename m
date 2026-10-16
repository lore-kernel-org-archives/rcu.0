Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8F4D6C55
	for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164140; cv=pass; b=He8wtfGElLwoZfwlF6FmKBoYuUwEBK7P/FM6MprmBiRXO2renykD1Od1mmQ9Fl/FMc7q3TwAzF7Q0a8p3GNDAJDsuGQfVzjTxZSTyfYYBamNxG2YUa6ahx379xkO802UWYF3MA7ix2ZQBBkn1vUMIgdsETIO6MPGGtKWOo76weI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164140; c=relaxed/simple;
	bh=hygWoDoiiFaRUycDUA+rE55Phd6JSI6v/3blQue02oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gonHHTeOFyVyN3V6IzbxEP6L1NexbQCC02yzt9mAZpHh1hW8zUwfLDgIN0Nw/H63XxIYEcz99FY6gQbYRZPW7zo8QA0TIWR2+LsfSZHQdiEyomJCxTeJcFIcxJhn/AGTNih11USMOPkO3NqTUc1GCbhgjHGeXuk8hlJMSVtO568=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j34pbPb+; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j34pbPb+"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c411e139259so833366b.2
        for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 08:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792164137; cv=none;
        d=google.com; s=arc-20260327;
        b=CU6/UsWoUmdDHQFQ5MKGclOFxTuDb1KtfAGsrNpRgPKgszwU904fd1PL/SUHnmyowI
         un/Es1PlkraPZOSLzjHq7s1XRKO+znTe2FSKvbK9PRMnoZlkUn2DGMdsWMfqAiRg6S5F
         9qGfEn3O9MGBhf4qAk4lJvRRfDqUZi9fd6AgkF+jnWPZxLPspqjwqgVHjN/plxGQwi/I
         BQH0OMqgBHimrtomcyqG9x9kOB9I+9tVjAj2w377Gkj4V1HxqUsJhwfKlx/DdnnU/g/t
         7YBtqMCUzZd7UZ8AEvsX67GHT6sgd07P5BLmzvJMsSrK9BvFOHWygEPndXuKudJAIz/b
         0N4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OmzRC93zKCNXf6CxRgu4BnImzgrqHIiKFgAbFPYhuWs=;
        fh=w0XWv3bQABF8My5SKsFJbl1P4L6iDP0EXIRflwFvSZw=;
        b=bdoZLgcQ45qq5ZwVzPETrqF4JBE4nVdgco3D2nXyUiwDg/rE61I4yU8nmgZfcs8NyI
         5zuk4MeAfUBOGPpqAjL93ff15kT8e+dAtM42Wd+ewudCDHddhZ4GrlIYYktzj3MPTh2J
         uPa4ExKcLKms9zI0iYNQ32UvJBttneoTkbaPaA0zSY8CtkuH44XRS5ObVesmx8aGIOj0
         7mwUWTVfY8p72wWmhTpA+epzz3sw2l1ubAuSVjvgqyCpHEVKQywm8aYtVJFcaklz6zeN
         1+6vpTaPTJDW9rT8zZkj56RTD4B7zfu2F8dPHhTajtNxY0mgM2mG/UrnzaGJVUMeihV0
         nSXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792164137; x=1792768937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OmzRC93zKCNXf6CxRgu4BnImzgrqHIiKFgAbFPYhuWs=;
        b=j34pbPb+K04EqHdbshpUo2QrFCJyYzON7wT0QtSFN6pIWEmS5Kug5AsFYg07gRSHib
         oIbQJvvPOfZq+uo9UUEJjrdMx0Dpt83O3KLNWXVUUxAaNrAK4MwxmupHzDTlf9M+aNnL
         5bvSr3XfcOySpG/ggqtyloGlmNihgqNLhsXV3KJolyyjAw+ObMsK7C/sGV+ocLuHrBjN
         jds+u2s8r0mySQ5gOzwioZZbcNK+4mtY48pL1b/vsyOKSHyX4wJ3Kwtqy7HJg1cjNaOq
         RGzmXXYyrR5zT7yz3/inAlbzJZ5NVAWe9oz+pyb6C6kqI7lCbtNSxc1APE61JTwEW12P
         4bsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792164137; x=1792768937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OmzRC93zKCNXf6CxRgu4BnImzgrqHIiKFgAbFPYhuWs=;
        b=OGdOvj0a+9+KybYdj+4B1iU0MiwBZk+rryfOsAjaxSILGEao+gMhZ9BpQwPwQ44Pw8
         smo/rMZCIQ3VPWz0xZJBYoNbaJgIWjrnSZjp99CwXgQypkRbt90U7mUPJxeW98s712On
         kpQByJAHgYfIBRJDYrLJXORUAoIHBsKxe0DwgOd+Cq3LEpehnRsliXxm6zGZ0QpPNObz
         qwsHe3PQXwsivrbPN8Eo4P7TbY/SU99hPDnZyGdLxx0mug/wgDXDb1TzY7Y9OYSkpNhm
         jMvsUp4Ym/gm4uQIwM/9wQQayLdQxlbFU+xYL8Ef4RyOduWmmmW0LP/6BaepSai49zqH
         cCDA==
X-Gm-Message-State: AFq9FYLrJz+VZj0bed1nYw/GkgDuPskbOIEOLOnzJiCMDtadaT0ghGiw
	kC8ksCyuGdjeHQh4/ztEtBSaFtruBYk/PsNUSJtjh2LDwWRwtYdu2c8DAA+h0gSDxK19sBSUc7W
	UenfGAirrsZZ1Zc8Mmpr8muV7x5Vg4To=
X-Gm-Gg: AYBFou29Sgo3lYl6mIQl7q7oyeT4pEbQ44WldYurC+Ipj255mZPSuEBkuQHoTxLu9nP
	O8MW/NpLLouqDfQc3MCV2FXBZhyL6PiJNT8qvv9qJBRjGtdRLrqEjzMD/dMZznq+waDDFhvW16N
	AndSbNlaAn6ON4X04uQ5dB+9UcyKFcQWHa+5xvSaqLWp7fDbNPSZw4XsiRSqiWGjqb+3RtPtC/5
	ki+J/nQGo9jl4iANFj8noKLl/sbOKKA+BYlKAaU1PG9+MAZ1jAYQb8p7PAY+BtTMJ+5ycDqOT53
	mrXvcjpY2xHE81T5p2KBoWbWEW+Bmr0QkbeAQcZbEH9Eb8wAp02dbgCRu+h0Psm+w+77bQ==
X-Received: by 2002:a17:906:8d89:b0:c33:62c0:d8cf with SMTP id
 a640c23a62f3a-c419da414a8mr10950266b.13.1792164136593; Fri, 16 Oct 2026
 08:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016102657.2347381-1-puranjay@kernel.org> <b18525e9-0508-42f3-8640-3177c5581926@paulmck-laptop>
In-Reply-To: <b18525e9-0508-42f3-8640-3177c5581926@paulmck-laptop>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 16 Oct 2026 16:22:03 +0100
X-Gm-Features: AclHuK-42tpc0eymjwM_OmVglORylMRaIXiQwcPGQUVb-mJBTY_G3rbayH_UySw
Message-ID: <CANk7y0i3CELP=xfu8vr4O4_-8ui9v4Odc3VimaSsw1nT16ub6A@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Ignore KBUILD_OUTPUT in kvm.sh
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun@kernel.org>, Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 4:12=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Oct 16, 2026 at 03:26:56AM -0700, Puranjay Mohan wrote:
> > kvm.sh builds the kernel in the source tree, and kvm-build.sh and
> > configinit.sh expect .config and the build products to land there.
> > With KBUILD_OUTPUT set in the environment, make instead writes them to
> > that directory and fails with "The source tree is not clean" or, worse,
> > clobbers an unrelated build.  Unset it so kvm.sh works from such shells=
.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>
> Good point!
>
> Should it (non-fatally) complain if KBUILD_OUTPUT is set in order to avoi=
d
> silently surprising any users expecting build products to go elsewhere?
>
>                                                         Thanx, Paul

I guess I am the only one!! :p
If you think we should do it I will send v2.

Thanks,
Puranjay
