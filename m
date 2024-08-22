Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88612183CB7;
	Thu, 22 Aug 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328248; cv=none; b=RCLh4uDjC9iBLzdX7cvdnEFHVGgnfNSZYW9s0/RLEg+adlwwP9aEDn0wocZosUFMR2H+jpC/0JxQ7tMo8KRfxC8kfZmehl+pefguo5AnVKycSUW4ozDyQ01vNIeCdaVBDHffNp74zd7iwdqW89mdHTCr94/Ag27x+ZpkoBgVjZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328248; c=relaxed/simple;
	bh=b2i1UyIA19HHknlm0wM6tx/e+HaRrcCa/2GwEuR9DrY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BReNIv7b0YyNOJq9+tULznkBaOrHADwvniN6AP8O9Mji7sqnMkv8dU3N2cheskIKgPDT3K3Vgjig2/koBNosGCYagZ5bQYRpyeHh8j67F9bO3wiOja0q1Dotf+2J0K0YqwIrAOlB/9Trl5D7YH22ICBThWILWnWA0Hv+7jU+opY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqVAQt6I; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqVAQt6I"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-533462b9428so1210573e87.3;
        Thu, 22 Aug 2024 05:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724328245; x=1724933045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ORE2H7Bi9/OqilhSDX+7ewEAaquD0x8jX2ZwC4dJsHU=;
        b=mqVAQt6IriumDvXky5QgmZTZrQtR576ktfZuKf0jZ79n9/puzVOyDi93MdkQVBV5kB
         C2TEIQikOQWQYyaY8XcBqIvtcW9g+rUaPl/D2Q0FgfsofpSmxqJ+yNFPCEaKKwEtJ8zI
         49qrw+n8O/z9OE9c3XtfBInWzhk08Ze5Din9UpEG2TlldVOFaHpxTDowGD3OyBtlITk1
         MEyYZY3R6hkxKN1tgBGT8rD+eURhjtfNUE7c46iml3i5SqeYkKaXvnm60CcKRrRQRRBp
         3V3jwvlhMrRnN6Eb60i9VRjutYF9tLiHZHpqlXbGzmkEFpKApLgb5SARxRVbpCCTjMAz
         6vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724328245; x=1724933045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORE2H7Bi9/OqilhSDX+7ewEAaquD0x8jX2ZwC4dJsHU=;
        b=OO3OFpc03uugPYg+2//LiHmcQo4MoPCneZh6wsOJcAkARuHGHqCYbQ+c/54s11nlRY
         d62JNqo4D8ijVFdWmUygfYz/KUWkvJyoXysXrw4ci27bMImIFDb6AHKcHw2lv4tjXb+H
         WF6fSvNjshjFTNheZ8/mWl0hFN2hB0li3pYxIMM6T4CVKiNK9qkb7U1K5B5jdI2DX76c
         BSdhENtrHS3m9Yq1VEjmxRmlaGixsO8HohfZBAuRqxU3++8TMGQEbSk+ZSG58U31Ll/u
         xft3ahYsAmikUT2uNm7dKcni3gAZYW/0aJtPSNoKqAkUYZPTQn4rNiqk6D4f77/DW1EA
         j8QA==
X-Forwarded-Encrypted: i=1; AJvYcCUS93SMOzcXvoKeMHG+2hy7MYOWGOSEvJtarvT/e+vQbCBi8LvWXbvYi8nzt7WwR03N1hA5nzx+/he7HwI=@vger.kernel.org, AJvYcCVe77Q80NtOnouVI7GfbABrpwWIDiEWa6ERXmbPXU3t5yCDAYx7lUqxMaoo3GoTPL7O23wN@vger.kernel.org
X-Gm-Message-State: AOJu0YyFaLlkozOlTKU0c5euiz384WH2KBimo9jI5w+/vMWuHizxKslH
	VYaziwC2ow35XFcAE0jU4o6AjnYGb19zdlcA9n+aJfWPFdSnK70GWCAkjw==
X-Google-Smtp-Source: AGHT+IEVu6F+vYWFapwOIsSBCZqfIGcTVjkndzoHwS5/90qXb1xwWOeD715zm01hBVFCmQxVkbQS5w==
X-Received: by 2002:a05:6512:318f:b0:52c:8342:6699 with SMTP id 2adb3069b0e04-5334fd64850mr1536544e87.55.1724328243955;
        Thu, 22 Aug 2024 05:04:03 -0700 (PDT)
Received: from pc636 (host-90-233-193-131.mobileonline.telia.com. [90.233.193.131])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea296b0sm243565e87.31.2024.08.22.05.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:04:03 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 22 Aug 2024 14:04:01 +0200
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2] rcu/kvfree: Add kvfree_rcu_barrier() API
Message-ID: <ZscpMfiyoRE95ZiF@pc636>
References: <20240820155935.1167988-1-urezki@gmail.com>
 <1cc13276-43fe-4c2d-8055-0a1a8a7ee156@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cc13276-43fe-4c2d-8055-0a1a8a7ee156@suse.cz>

On Wed, Aug 21, 2024 at 08:06:08PM +0200, Vlastimil Babka wrote:
> On 8/20/24 5:59 PM, Uladzislau Rezki (Sony) wrote:
> > Add a kvfree_rcu_barrier() function. It waits until all
> > in-flight pointers are freed over RCU machinery. It does
> > not wait any GP completion and it is within its right to
> > return immediately if there are no outstanding pointers.
> > 
> > This function is useful when there is a need to guarantee
> > that a memory is fully freed before destroying memory caches.
> > For example, during unloading a kernel module.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Thanks Ulad, replaced the patch in slab/for-next
> 
You are welcome :)

--
Uladzislau Rezki
