Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F8D22541F;
	Wed, 26 Feb 2025 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584578; cv=none; b=UYw1Keywyih18NN9Kp8qfcPVfOp1lmkh8UK2md6VHxBwQXuot6QNsw+Vn2s35WywbMymPz2weskHgsrkG+lY3yOOw+LrPvxI9VvbuLtJrZZLGSiaBcdsgaMehSnB+XhuRKYp5OQwjanDlTk0j7UDY9eN/pMvqkFRsK7cxt80Eok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584578; c=relaxed/simple;
	bh=y2U4LiplXrqnccDqV+8uusl1+bnBBatPfxdZRviXsbE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZ88lm1Js60fnPJK9F3ooh4VAPD56oNrqqIdg6l8yaIiAyIwrFePmMb9WzM8Xad9DioKXcAR+1ptH3atwMEZkAWSG413xFjGtc6L3GjCndSHJpB5KbXgJNmjRTt0SKKrjt8f+wnYQk8dNe8/IYDDc0IOtsGsTfolKnlMb78plc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8UxfAq/; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8UxfAq/"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3078fb1fa28so54782341fa.3;
        Wed, 26 Feb 2025 07:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740584575; x=1741189375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EC1eEy16dWk77oUwR2C/pnSf364aeM1Gi+/TEG7RfzQ=;
        b=J8UxfAq/b1A8CKRW1adinMe8HL/aesxCubfLsvL0xr5Ml6P13zgAX9IlxwiR2+6dED
         lfCMDorBY5D510f2TZGrWvFnrh0GM7BKGIG5Ak9pLkEivzT9m+MvBtroRp1VtYzqJaaI
         J9OtLr1WK82ohmGnYRZ2iMTZoqEmyx2+GmnRYjQ45yR5dkCj0CoDSyiB29qhZJjvBwWE
         wSe2+XDGseUepAkQhI8+DznPt9oKvUJklZywEUT2DMyjhz1KIf3pQ3iVpYZWm+5WDan1
         SwT66l3mtrE8AUZbvkK6oGVg5WaBESOiZcPAZ6ffo/jtYAvdnJV5/ePBl7A2f0IfExm2
         EmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584575; x=1741189375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EC1eEy16dWk77oUwR2C/pnSf364aeM1Gi+/TEG7RfzQ=;
        b=j1EIhKK81M3Y8eGtLAzYhOYGMJLJ+rltbcsPsODGSaJZgHNzctIx4PIobAKB7nKU0z
         a2yUoiKMrRMaHkOwg+nbqXvIhV16+lL11n44WZd54VQMhyXf4TcpxeIblVHJ693rLK/Q
         cW+P5iqgvR6Vmu+SSGZBdRuAwfm12vSvGB+OibtRp7qC+03o8JRknV5etZFdnYNAm7TW
         J2DLDgLFXeI863lVtY3kb+wkcmu39rZKwJcMF1apjQr27CrDNqHJhhoByEH03i374/FF
         0jtL72o0caSMSMrAKk18/wC0VGG9sDlp0fufRJExNa8ZfccFbn6oVwxiE9Fk/hUBfqPv
         04Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUGoz8g0JMtpIu+49YsOpejlCxQo0UYeuNoaD924M9GLn/QN50C02Bqz+lVF9zRkzzEn1sg@vger.kernel.org, AJvYcCUnGe48OgLe0EJ79t+nnFf71iJ0t8eayzsWP5zf6kx6n05EzHFy3pBYMiISil6aQMkPhPEXsGaxEappzWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyczrAxePrv8MTAzYneKm77JYk6lXy6BhcflF3XCTRAC1CA0eWK
	VqqEtG7Taa9Jb0k6s+jQ6K20m4kIt/8X+MwXUAA5uRyIV6NJ8NW9
X-Gm-Gg: ASbGncuQZohe5Iy0DOy9tozhoMdZZpKtg9JoAMagGwCKAkfTGdd7jKRfcUr0qJM1IFn
	jA6trDJw4jdHoO7MT3cR38LlxtItJ437nwu7Ntq/8aqxnoYM243KLH0OfQ4/NIgzOhKsO9NuTLN
	Pr/2D3sIPUL4aesz9dFevo8onM+Uq9iejBDR0zpflT0w4/g4v6MOB5Ryj/D65o9ZLh5KnuoY+mc
	oCJ7wF/hJ16EpZqv5CrnzOvSno3M9WlelfjXSimQgDaBIURHLyycRLBQAWLF2MEzZnQHwa9jcgR
	19Y5Lw5XmcxcXP/IcgwlTuuqdTbrZBkucrFrFWWq+y9QbheO
X-Google-Smtp-Source: AGHT+IGXJ4oZ/znpdkecPp5tddj+wrT+wUd+ZQGedDdTB7EiMlBVxjC98UHDukKm8jBLnJwAplj21Q==
X-Received: by 2002:a2e:3207:0:b0:309:bc3:3b01 with SMTP id 38308e7fff4ca-30a5af4c7bbmr85358301fa.0.1740584574916;
        Wed, 26 Feb 2025 07:42:54 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819ebe39sm5640871fa.28.2025.02.26.07.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:42:54 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 26 Feb 2025 16:42:50 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Keith Busch <keith.busch@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-nvme@lists.infradead.org,
	leitao@debian.org
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from
 kmem_cache_destroy()
Message-ID: <Z782eoh-d48KXhTn@pc636>
References: <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
 <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
 <Z74Av6tlSOqcfb-q@pc636>
 <Z74KHyGGMzkhx5f-@pc636>
 <8d7aabb2-2836-4c09-9fc7-8bde271e7f23@suse.cz>
 <Z78lpfLFvNxjoTNf@pc636>
 <93f03922-3d3a-4204-89c1-90ea4e1fc217@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f03922-3d3a-4204-89c1-90ea4e1fc217@suse.cz>

On Wed, Feb 26, 2025 at 03:36:39PM +0100, Vlastimil Babka wrote:
> On 2/26/25 3:31 PM, Uladzislau Rezki wrote:
> > On Wed, Feb 26, 2025 at 11:59:53AM +0100, Vlastimil Babka wrote:
> >> On 2/25/25 7:21 PM, Uladzislau Rezki wrote:
> >>>>
> >>> WQ_MEM_RECLAIM-patch fixes this for me:
> >>
> >> Sounds good, can you send a formal patch then?
> >>
> > Do you mean both? Test case and fix? I can :)
> 
> Sure, but only the fix is for stable. Thanks!
> 
It is taken by Gregg if there is a Fixes tag in the commit.
What do you mean: the fix is for stable? The current Linus
tree is not suffering from this?

--
Uladzislau Rezki
