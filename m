Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E5D1C6BE
	for <rcu@vger.kernel.org>; Sat, 16 Aug 2025 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755311725; cv=none; b=P64g6saxHXguiOFx1bAVAQZKMrH5Y9eSoHsLgIg15cKWy4LnJGBlO5BUUuexIvDdtUbS5640RR1iCzENdYGrXgfVokMbVfrablWi3n6+kW6CWWJLFFAV65vTuPi6H3e50LCXtNNSKx4BD5kuv2bBR4L/QznMN7cKWm8G2CLS5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755311725; c=relaxed/simple;
	bh=izKkYZyKE3NDGI1sM2L5pcWgCNJg3k/86kjkHcLqNgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPvgMSf/u1XJYUfBG+3e5uZTiQ8ti061y6Gc7zc2XrTeQyoV/kKWngmeoLCgIc//UDLUG2UeLyEJTjAY3DMAB7tDzK3I8BI7Bz8PLlcRPbbEg82RY0YkrIdeUkM3ohEfkBXCPGP/19IeLkSaZ3cxqa5dUkygNm4H0HGxUmFBPHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LAarHHci; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAarHHci"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24457f3edd4so18252885ad.0
        for <rcu@vger.kernel.org>; Fri, 15 Aug 2025 19:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755311723; x=1755916523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYSYnsAnc4+Pe25joGiiZuFU50uPj3OZL8WRBpyuG54=;
        b=LAarHHci//B2EUfLYTtJbPQhcfQ72afSaYsFanA+lvVGVChWiE5OsVL9QG4N6ic76N
         rI54jMorIr4eX/PhX0qAlZB2X+stOkOEyqgZfvJ7pOhWxrYeYuSwkiW3NoJ9emnriAXy
         xIFb2IYh97xFrTgl6Jyn1ixC80i1rPZC1DDqIIOc6xNnPtK00Kc67wEhXPKyWff3OXO0
         UW6+L8wcTjg4Tfe7ZmgjiGoNa+FkponP1Jn8s4hNQCFpjBKa17kD9Z6Xj+YCDgxEJ9H5
         vLYZpl2tbGDZAi/lK2H8utNDN5QudI75m7WbKjlMCOsb2iOfphAb9LYUlVb72DeCUczN
         xfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755311723; x=1755916523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYSYnsAnc4+Pe25joGiiZuFU50uPj3OZL8WRBpyuG54=;
        b=H/jrprnQLbvft1DfN+etMNTf2SRawS6iRHi2d7G7kJ3Pe6gF75/u+HyCj+kpiwQDej
         plYRXlMyr6ZEE46FVXd/YD+Bi5sp1m3bPYfC/4S2bgtHFHLbj/blO0aAxGIJSnPRNCq2
         4PVCP3SVYcRTsqFKrVCiP56gdkswVijToWW01X9eOB0xGG55GvUrPy+8TsohROlRrMUE
         1CiNixcefnt+ErMjRoKYIyGg8iFLvzxBJDS9dXxxXFAKFCzDFAaoq+lAoCF1oy5MfUW/
         ncrhbl4jG556bK9FfHtDNweO+HrJWUZr4HH4obkQqx9z/PXUKkxNs9yoK+jDZuTfHZDy
         35hw==
X-Forwarded-Encrypted: i=1; AJvYcCXKX+4D978qqVPd75kyjfiArK+2o6JOgv6jcTKBSuLmJjyQnPNQGaAFu77752f5FMIQNHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF1cfp1+9YiOkN9rzbJv9J21y3BlP/ZKC1n4ZtPk32NEXuoBtL
	vzw2kZRMepMUVulmT6cHyJ9LabqeN9CHWjG7sNXol33xpqGf7hM4plRm2gi7aVCMK9A+S8qy+WJ
	ugh58l8+uTzCfi353Bb8Hve7SE0rFrMhiLsjh7bZo
X-Gm-Gg: ASbGncssRTy5+SJxOHNZBmVRBZfo/yshSuIAE0djLpScmpJcuwv7Yt4rh4SoLWO8pFo
	YJNQ6CIOc1s9HUGiy3gC1+/70BmZHs2TpNiZwAl1Qsx+XKeVVl/4zYU9xQYVbS2/JWyB79ToO1c
	3Pb5PlvTlbtqZIcyDeF2Ei59smSGeDBGYMh2pYKHUSsDkNmZ6+QrpDs8DxGQmPmwCAlE93JdbD6
	DkQ6Nx7Wkx5q9t4hFkcK/VrbXoW+ShJ5WFfePs8uhPVhdU=
X-Google-Smtp-Source: AGHT+IEoa6K5VPw7SESWJcyry0r0EAmnREWUavxXpMAeN45Ss7wHcLf9j0oo8tGG9DPZYtegphKPTtIWix2PRHyIVkg=
X-Received: by 2002:a17:903:1967:b0:242:a0b0:3c12 with SMTP id
 d9443c01a7336-2446d9c534amr60239055ad.52.1755311722577; Fri, 15 Aug 2025
 19:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801090949.129941-1-dongml2@chinatelecom.cn>
 <202508110750.a66a4225-lkp@intel.com> <aJ_qbZDvDJwVoZGA@localhost>
In-Reply-To: <aJ_qbZDvDJwVoZGA@localhost>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 15 Aug 2025 19:35:10 -0700
X-Gm-Features: Ac12FXxRtAJ-Rrz7HjZK8VbUPj4MqgpSheT6l3cFeoFUPq4dJKBOPfSiUKanWVU
Message-ID: <CAAVpQUCEGiRjoobf69Jd5M9vnZyi0N6crNUgSBpDTGNfrap1cA@mail.gmail.com>
Subject: Re: [LTP] [PATCH net v2] net: ip: order the reuseport socket in __inet_hash
To: Wei Gao <wegao@suse.com>
Cc: kernel test robot <oliver.sang@intel.com>, Menglong Dong <menglong8.dong@gmail.com>, kraig@google.com, 
	lkp@intel.com, netdev@vger.kernel.org, dsahern@kernel.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, edumazet@google.com, 
	horms@kernel.org, oe-lkp@lists.linux.dev, kuba@kernel.org, pabeni@redhat.com, 
	ncardwell@google.com, davem@davemloft.net, ltp@lists.linux.it, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 7:18=E2=80=AFPM Wei Gao <wegao@suse.com> wrote:
>
> On Mon, Aug 11, 2025 at 01:27:12PM +0800, kernel test robot wrote:
> >
> >
> > Hello,
> >
> > kernel test robot noticed "BUG:KASAN:slab-use-after-free_in__inet_hash"=
 on:
> >
> > commit: 859ca60b71ef223e210d3d003a225d9ca70879fd ("[PATCH net v2] net: =
ip: order the reuseport socket in __inet_hash")
> > url: https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/net-i=
p-order-the-reuseport-socket-in-__inet_hash/20250801-171131
> > base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git 010510=
12887329ea78eaca19b1d2eac4c9f601b5
> > patch link: https://lore.kernel.org/all/20250801090949.129941-1-dongml2=
@chinatelecom.cn/
> > patch subject: [PATCH net v2] net: ip: order the reuseport socket in __=
inet_hash
> >
> > in testcase: ltp
> > version: ltp-x86_64-6505f9e29-1_20250802
> > with following parameters:
> >
> >       disk: 1HDD
> >       fs: ext4
> >       test: fs_perms_simple
> >
> >
> >
> > config: x86_64-rhel-9.4-ltp
> > compiler: gcc-12
> > test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30G=
Hz (Ivy Bridge) with 8G memory
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202508110750.a66a4225-lkp@inte=
l.com
> >
> >
> > kern :err : [  128.186735] BUG: KASAN: slab-use-after-free in __inet_ha=
sh (net/ipv4/inet_hashtables.c:749 net/ipv4/inet_hashtables.c:800)
>
> This kasan error not related with LTP case, i guess it triggered by netwo=
rk
> related process such as bind etc. I try to give following patch to fix
> kasan error, correct me if any mistake, thanks.

Note that the report was for the patch in the mailing list
and the patch was not applied to net-next.git nor net.git.


>
> From: Wei Gao <wegao@suse.com>
> Date: Sat, 16 Aug 2025 09:32:56 +0800
> Subject: [PATCH v1] net: Fix BUG:KASAN:slab-use-after-free_in__inet_hash
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202508110750.a66a4225-lkp@intel.co=
m
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/linux/rculist_nulls.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.=
h
> index da500f4ae142..5def9009c507 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -57,7 +57,7 @@ static inline void hlist_nulls_del_init_rcu(struct hlis=
t_nulls_node *n)
>   * @node: element of the list.
>   */
>  #define hlist_nulls_pprev_rcu(node) \
> -       (*((struct hlist_nulls_node __rcu __force **)&(node)->pprev))
> +       (*((struct hlist_nulls_node __rcu __force **)(node)->pprev))
>
>  /**
>   * hlist_nulls_del_rcu - deletes entry from hash list without re-initial=
ization
> @@ -175,7 +175,7 @@ static inline void hlist_nulls_add_before_rcu(struct =
hlist_nulls_node *n,
>  {
>         WRITE_ONCE(n->pprev, next->pprev);
>         n->next =3D next;
> -       rcu_assign_pointer(hlist_nulls_pprev_rcu(n), n);
> +       rcu_assign_pointer(hlist_nulls_pprev_rcu(next), n);
>         WRITE_ONCE(next->pprev, &n->next);
>  }
>
> --
> 2.43.0
>
