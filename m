Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380A1D63D3
	for <rcu@vger.kernel.org>; Fri, 26 Sep 2025 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758930344; cv=none; b=ui/t2czr6vgvIIRb40/cZtfAKMYd6Xm1P3rrr7cCYNlpuS3uwLYQRiR5pLthM23TcCjq72562Nt3z79YlYQ0usZ6rQBeSphpElX65P+NKW76KLppMc9xUrQJ+YAdbk3U7Rx/qQelYkV13nAhP5s8rIwWgaxjYrlXsCBJJhB1/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758930344; c=relaxed/simple;
	bh=L/vIybsN3LeKF+j6ObWJ3KQFN6JCwMXCVroUvbrCQ9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQmQbNrNlc1I59rS0R+Qj2GMUBFceME/JllXbM89bc8xr4gh/OMZBT9+7IfpWJo6GyAznmByhKSJFZpPrTuPTnjKFGudIDHy93QWMtH6h3pWSihBkNXfgTsw2WlRCUMV+1+gEFwQX6M5gBvJZDTMC4BUiO2TwZN3y9yI5dg1aPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSvdm7Gh; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSvdm7Gh"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4dcc9cebfdfso68801cf.1
        for <rcu@vger.kernel.org>; Fri, 26 Sep 2025 16:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758930342; x=1759535142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2v6l/fjiZwwbxRv7L9dB6Gm8kHK4dyhIGUYaK+C169s=;
        b=YSvdm7Ghwz1ZbHcyT8ubhE6WSgtfx3yaUBsRhKmCuG5Rxh2JPnBlias8siDA4aArtk
         iRFmGi+/INGAgKw8w/xap/M45Admda4AueUoiwHhRtbdSjxFVVZ3T8ejuvvteurjbMse
         9mKf5Hps1MnvcSua6bFmfMAg0ktYN/39UU8VNwHVBh6dFobylE40a3NtD0TrOvj+USLV
         HaPxwSajVK+VWCdzZXxRM016y22a5/5DSqGP/Z5njRCf/SuDtIotSIqnJeIJz8HcNJMq
         MK2DEbWoehYQKH+pLHiaGggCmHNiGQxH9NftZQRkgSqlUv1XJ509rD+LEgueiJ4pHcTF
         0xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758930342; x=1759535142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2v6l/fjiZwwbxRv7L9dB6Gm8kHK4dyhIGUYaK+C169s=;
        b=AdT/IPSHf3qQcF6PbbpmC/eBhGIvaGcyhOOCNiVu4whCwuH+//742mdMjSbY7azdgQ
         Rh3cT4F+g1jeRkcw8Wi0ljIJDqHc9PJJXBGb+9lnntKteEvcfQNcpUsoEjV0KPMwkFxw
         H9XSEbaQDhv/n6nM8GdejRsfsxmmG1Yv+TQsmMGi6DsmvSQIMzk4Bzmt1U5Mdkq4UFSU
         cf8MjY/F1Uo63S3eIDvDDiXP2gsFFW2SamNVHZ8D3socXGy1zyI5EGyqr9lvSLpHbiWE
         GpfVISTfeuAjEbM7yJKZPRgd2/pqsDw/Jvnv3ujdqPBbwnqlrN26Ao746mqTuJO7bHyQ
         pK2g==
X-Forwarded-Encrypted: i=1; AJvYcCVQYhjnfLBqfNVSEzdYE4EOiqiaNQ+6CxCauNCABgS7i4e6/nMThc297cFACL7kmvFaFMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZjJErRHdF/srIgteFyg5zZU4AOLgwivmX5Tz4/1FP1fLpVkSj
	hjwijQuJ3Gr5jKzlPPfsLI6cu836maOFmAUknpJPEy7A2hHiLu1uPgn0sG3VQwSjpSQdUGcKpHY
	x+0fLYK5WwLG3R6Bet4aI13WKrq+hX50JuOJdhzRx
X-Gm-Gg: ASbGncsS8uOBgFvCxOP2qJ+qSzyXe8iYL3CjzRz0ufmQYjG6nNd6YCU1nbjMU46lGKd
	go4KzWHIzqSg8GIA1oLrwJHJB5Xf4VAdu6aGMcseXxNclSlSqPlbmZBFWfjh9+K0FhVaBuIWZ0c
	zS990SEyX5GCdmmb1UA6Evim78W0fNxqE5PYNT9ziDRU2BYKH4SEMB+EuPwImVJWltPcAmL3Mka
	NiobdKPYZSb
X-Google-Smtp-Source: AGHT+IFXlGPNT84MM6UDMyxHqowIC+dEanCYd/TyBPjybtAKnhlvS2IM+5MVQP+4ScKwabi2zbY1N6OMYsUijzd9Dt4=
X-Received: by 2002:a05:622a:5286:b0:4b7:a72f:55d9 with SMTP id
 d75a77b69052e-4dec710b632mr2671331cf.13.1758930341409; Fri, 26 Sep 2025
 16:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-16-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-16-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Sep 2025 16:45:30 -0700
X-Gm-Features: AS18NWDlkUCiWuVTsoik1lE1b7RxpxL96KRj-TH3et2oYHZB4-tROqStc3p33LE
Message-ID: <CAJuCfpF8TDS0bjksssRJyvxnr1Rbb2SpgRfRAxJmPS5oQz88dg@mail.gmail.com>
Subject: Re: [PATCH v8 16/23] tools/testing: include maple-shim.c in maple.c
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> There's some duplicated code and we are about to add more functionality
> in maple-shared.h that we will need in the userspace maple test to be
> available, so include it via maple-shim.c
>
> Co-developed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  tools/testing/radix-tree/maple.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/=
maple.c
> index c0543060dae2510477963331fb0ccdffd78ea965..4a35e1e7c64b7ce347cbd1693=
beeaacb0c4c330e 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -8,14 +8,6 @@
>   * difficult to handle in kernel tests.
>   */
>
> -#define CONFIG_DEBUG_MAPLE_TREE
> -#define CONFIG_MAPLE_SEARCH
> -#define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
> -#include "test.h"
> -#include <stdlib.h>
> -#include <time.h>
> -#include <linux/init.h>
> -
>  #define module_init(x)
>  #define module_exit(x)
>  #define MODULE_AUTHOR(x)
> @@ -23,7 +15,9 @@
>  #define MODULE_LICENSE(x)
>  #define dump_stack()   assert(0)
>
> -#include "../../../lib/maple_tree.c"
> +#include "test.h"
> +
> +#include "../shared/maple-shim.c"
>  #include "../../../lib/test_maple_tree.c"
>
>  #define RCU_RANGE_COUNT 1000
>
> --
> 2.51.0
>
