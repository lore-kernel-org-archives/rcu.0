Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365217ADE8;
	Fri,  9 Aug 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220640; cv=none; b=VrY0u2UQQBaSjBjYSzi4XODBs7RQMpjckz9mG/cl6vrUvXThOlrWTEEKOPDnq7H51rzNthHGri9CfcZXiguep3lSZDIQ1zntATEsRH0fmIUvTrlgLP0hWYxS+yAqQdCuQlvHMi+abZhOh4xmsliAcfaa4uBzJKk2JLBrO3vdp4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220640; c=relaxed/simple;
	bh=MuvI/xFsL+CNUTH19sViET9s8LJFVNCewQGI5dvpEMM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOPMZSxCv10YR/2qMRfsF/oK5FxNInNgcEvcVWVIlyxJ/yOsDwZ4mZi24HSfSxhIQAgvru51k3RlnD3tEDAtN5aukjOw/lYfdtVZWWkPMfUIB15/vBk0lTkl5WiKxiORBWcNh55Dfo8C2DI4zh6HqGfiEGiKVrPPqbvUPlI/atY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDDV5QGe; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDDV5QGe"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52fcc56c882so2260936e87.0;
        Fri, 09 Aug 2024 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723220637; x=1723825437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=urwFjYIe54BX21GUD0rDONyqjA52hcZTxeP+KnuDeBc=;
        b=UDDV5QGedSofUIUmfpKN0ZJyuq+PpgMq0bjMu71y1/T6Jd3Ia281YQeyoZ33+lWQSl
         Jan8qAdelWAviRoWN73SZlk/ZQ8W0osj/lYW0tPd7mBkgMUJ0sfHbpCrCy/Om1LF6+yo
         L61/ByseoyCJIAMj21oweh5gjbpJrkEdXxrNM//PQ0ZJLPSKfqkosFki3h3AUqXg4Iif
         +dhjFjXmX3/ZhUwQ1L6C5OtQeYUqXEP4guipYTtzc8L6fxTefGcSzxKagbQBDv+0YUAs
         v5K1d6bCA84RJmSsZ/QRD+OE+o3o+lwSCQpa0ONGclfaQH6xyVF+v/Jtkzo+xK3ahCxJ
         VSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723220637; x=1723825437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urwFjYIe54BX21GUD0rDONyqjA52hcZTxeP+KnuDeBc=;
        b=qK9H/lYMysZtMce+oci9yAtc9HSv7KZsgFPnfObu4R3eRztFYQNYmURx5cfnYGiChF
         axYI+ttAwYdrVkmcph2LLSpPphL2IZLo1X6RItDQgV4jhcfy7QPmzQzzRbQMqPV8uy2o
         Nhljb1ABoK2tYcohILVAsUbbUI0TMnnb7JnXYxYun7NAmvW9jC1bje1pNlw3L/QAKi9F
         Y0gzV1bdgSidsRPnu7evJp4ukFDS/I15He8F6tGuHhTQUL/TN0xRxJv2YTVmoBIWKLXS
         POqPvX3vCPicI+rLyLMDSxwNhCIflLU1lgoaRBClkDBWyGokhOzzjQGKZTGgGwut7fQq
         6Q1A==
X-Forwarded-Encrypted: i=1; AJvYcCU67kzDSKSckTvixP81dBh+TDD8bIIazDDAV8+Mjtv4uoftNKCiuDf9qb9p9K2y2fFLsRPGbaLHNGR2KtQZbqSOfnMtZbqJ0c+mKp5UgQP4iOTpUcbwc34DhS2JBrTBclAv
X-Gm-Message-State: AOJu0Yw285Swzb62aUdA96K4XBer0AhY8SFr1//uFuEl6C45WKYwHwL4
	IU+OCF0nK/9DIU+Ij5357Q+YTun92WchWQAXQmFpg2NbJML1/Ff+
X-Google-Smtp-Source: AGHT+IFVbMvFAZSc1sQVj5YuOvjL6UcHN+fDMssrAbMlFDr0AaxMw+YNalTFTi6yIa269yVuOEZoYw==
X-Received: by 2002:a05:6512:3e28:b0:52e:fd8f:624b with SMTP id 2adb3069b0e04-530e5de775emr1601552e87.29.1723220632467;
        Fri, 09 Aug 2024 09:23:52 -0700 (PDT)
Received: from pc636 (host-90-233-216-8.mobileonline.telia.com. [90.233.216.8])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de3e313csm1030750e87.55.2024.08.09.09.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:23:52 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 9 Aug 2024 18:23:48 +0200
To: Vlastimil Babka <vbabka@suse.cz>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v2 7/7] kunit, slub: add test_kfree_rcu() and
 test_leak_destroy()
Message-ID: <ZrZClPolptzUgSr8@pc636>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-7-ea79102f428c@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-7-ea79102f428c@suse.cz>

On Wed, Aug 07, 2024 at 12:31:20PM +0200, Vlastimil Babka wrote:
> Add a test that will create cache, allocate one object, kfree_rcu() it
> and attempt to destroy it. As long as the usage of kvfree_rcu_barrier()
> in kmem_cache_destroy() works correctly, there should be no warnings in
> dmesg and the test should pass.
> 
> Additionally add a test_leak_destroy() test that leaks an object on
> purpose and verifies that kmem_cache_destroy() catches it.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  lib/slub_kunit.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index e6667a28c014..6e3a1e5a7142 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -5,6 +5,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> +#include <linux/rcupdate.h>
>  #include "../mm/slab.h"
>  
>  static struct kunit_resource resource;
> @@ -157,6 +158,34 @@ static void test_kmalloc_redzone_access(struct kunit *test)
>  	kmem_cache_destroy(s);
>  }
>  
> +struct test_kfree_rcu_struct {
> +	struct rcu_head rcu;
> +};
> +
> +static void test_kfree_rcu(struct kunit *test)
> +{
> +	struct kmem_cache *s = test_kmem_cache_create("TestSlub_kfree_rcu",
> +				sizeof(struct test_kfree_rcu_struct),
> +				SLAB_NO_MERGE);
> +	struct test_kfree_rcu_struct *p = kmem_cache_alloc(s, GFP_KERNEL);
> +
> +	kfree_rcu(p, rcu);
> +	kmem_cache_destroy(s);
> +
> +	KUNIT_EXPECT_EQ(test, 0, slab_errors);
> +}
> +
>
Thank you for this test case!

I used this series to test _more_ the barrier and came to conclusion that it is
not enough, i.e. i had to extend it to something like below:

<snip>
+       snprintf(name, sizeof(name), "test-slub-%d", current->pid);
+
+       for (i = 0; i < test_loop_count; i++) {
+               s = test_kmem_cache_create(name, sizeof(struct test_kfree_rcu_struct),
+                       SLAB_NO_MERGE);
+
+               if (!s)
+                       BUG();
+
+               get_random_bytes(&nr_to_alloc, sizeof(nr_to_alloc));
+               nr_to_alloc = nr_to_alloc % 1000000;
+               INIT_LIST_HEAD(&local_head);
+
+               for (j = 0; j < nr_to_alloc; j++) {
+                       p = kmem_cache_alloc(s, GFP_KERNEL);
+
+                       if (p)
+                               list_add(&p->list, &local_head);
+               }
+
+               list_for_each_entry_safe(p, n, &local_head, list)
+                       kfree_rcu(p, rcu);
+
+               kmem_cache_destroy(s);
+       }
<snip>

by using this(~11 parallel jobs) i could trigger a warning that a freed
cache still has some objects and i have already figured out why. I will
send a v2 of barrier implementation with a fix.

Thanks!

--
Uladzislau Rezki
