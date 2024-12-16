Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86812040A7;
	Mon, 16 Dec 2024 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347026; cv=none; b=aT+abou3lSSEYmQ8yJQyYddXv4NIR+7xWBR9bHpSUwkgWwMr/DJVMA+kiGYeT8RnCL7YmU9lGQJjU69PZwWEER4CCTa7AhIG53UahUFRKb/PTzuPqAhxS814zMXY89kKWcZurna+1DKYLoZBW+TnrR1rmz2AZ6W7jShdUmN3jRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347026; c=relaxed/simple;
	bh=k95fXMavV9mnMZ7GK+gCGNZ3iThKn/UBOA8ho8NOafo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLLNTx8NTXZPlG2apNNMDC2VGg/7phISXGhOT3CBgRLCAmSw88wqeFeHQJt3Iwb7EDKq1WDz2aUEJHO4fIkpuAap8JMfxCrDmD/JkBzMNAkgNDHgL7ntZ00kx2s3d8ZYatJJlk8u3qlgB3f8Lz3q4mLEeL4kSMwatbsr4J6lzB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMj2kW0V; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMj2kW0V"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3022c61557cso41895751fa.0;
        Mon, 16 Dec 2024 03:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734347020; x=1734951820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wRXGX3wdH+oqcCyvYkhqVDvUj0B3vnY2uEQUPlXVtyA=;
        b=dMj2kW0V/4wihR0LcCGdtajRtbb+zL0HoUDtuznF/gMuegC7ZjdWLGVXQLW3/YmR0M
         9Sdx70WDUoeOTdBBccdU8fc/ukk/alpUAZJoE2W2SUFuQxK+cn1QF4OEW+o8oc83eH5X
         8lphL5axdjS8zq+0NKKd3h3gZle3lfxt8x4hNfUlg3TvkMrS9Ty8H6T3rSa34LCS5Vhm
         MMYcLQCS5G1hLm4iAd3GioMGtS+QwK53KYz28x29fbTVpJycMv8mPpmrBE17VroD/5//
         xRxFEwl6WunHzEvTGpszkeh+V7H2BuUC3yy810ZSuuexNE31ofbJMHpejLd7h2YxD/Rd
         Kp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734347020; x=1734951820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRXGX3wdH+oqcCyvYkhqVDvUj0B3vnY2uEQUPlXVtyA=;
        b=pmQaHgeQA8V+mA2f5g5OiTFaTokmbToTFLxYPbofQHzSsjScevsTl+emvTyrGVnr+e
         5AA8+BYG0ub6ITaJ+0tcrxkY/9DwrJrM607+6HwDgwUXEpLVfkwRdTfvgZLuCjbgjk7H
         vGpdaC4win5FI5QE8MYKfCh3iSL2MWx47bs6CFzJ8S+jXAkSpDHudoRFyjop3H0nONs1
         lHzSBajSygbAk4wZzzknCjjBpIzf7ewCqptvgbUi2zgXgBHmVb6sS2RcJ/y4NAiLd7bM
         sGlKF4ldTWUBw1IYJTXEDtij7ki37Yu3/cKJeHIevgkWjOfmRADSZj0Q7GHLBHvkc1FG
         UWtg==
X-Forwarded-Encrypted: i=1; AJvYcCUnpa19hFrhHgVhN0UckEV2FGmb3dpQWPy7zJXQfQC3cfHEoDzyFvrVK2H3czpJVHjc6XFhSUpLjvJBNmQ=@vger.kernel.org, AJvYcCVWbNrBWJJ0rRg/tWqGkOsIRIt3hoD4kPedif9Vo2tBRB3qQMrffcgy4URVqxl04w9csLba@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZbHt5aySACqe8hWus1Bc1L/Gk2tQL4VdqmtvVn92Ya18Bo0K
	AxGAAhkHCGPKA0ch93fwn+APkKD6UJgQZ7FIsZhK0l4FsmSO1jg+
X-Gm-Gg: ASbGncuNg6si1SMkKg1gvlfoEVVJ2Q7zs4FOo5ulnjuR1H0h/LQy7rJXAd6l0c+Sk2x
	2YvHDkXdxfxY1adYnr6H2YuMjNXX520cElGT6Q3XsQBxYlJ1WiyJHLAr5JEVvuY4Bb7IdLkHZ0P
	At3ZSvFQBBnoGo1nHH3PGL3lUpMBBvCVYuGOYy3yV+jypOTI/8gAJ3dG2XDfW5vYYDce4mYrT3o
	YHmZaZiOC7uCb/n3YEtm2eb1uLae492Qjf43gf8iLc+cXbJDo1zZkjRZTnWj1heMtJwJ0wh261K
	bNA=
X-Google-Smtp-Source: AGHT+IHTu+UsNTcCQATOvGryOILX7Z4tdC3dgpY+2CIY/ImvJH66I6x7vITTmDgkL2xalUPlQqnXrw==
X-Received: by 2002:a05:6512:ea1:b0:53f:231e:6f92 with SMTP id 2adb3069b0e04-5409056162amr3764697e87.34.1734347020125;
        Mon, 16 Dec 2024 03:03:40 -0800 (PST)
Received: from pc636 (host-95-203-7-38.mobileonline.telia.com. [95.203.7.38])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c20c64sm821302e87.252.2024.12.16.03.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 03:03:39 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 16 Dec 2024 12:03:36 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
Message-ID: <Z2AJCI3cIR9ETFFu@pc636>
References: <20241212180208.274813-1-urezki@gmail.com>
 <17476947-d447-4de3-87bb-97d5f3c0497d@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17476947-d447-4de3-87bb-97d5f3c0497d@suse.cz>

On Sun, Dec 15, 2024 at 06:30:02PM +0100, Vlastimil Babka wrote:
> On 12/12/24 19:02, Uladzislau Rezki (Sony) wrote:
> > Hello!
> > 
> > This is v2. It is based on the Linux 6.13-rc2. The first version is
> > here:
> > 
> > https://lore.kernel.org/linux-mm/20241210164035.3391747-4-urezki@gmail.com/T/
> > 
> > The difference between v1 and v2 is that, the preparation process is
> > done in original place instead and after that there is one final move.
> 
> Looks good, will include in slab/for-next
> 
> I think patch 5 should add more explanation to the commit message - the
> subthread started by Christoph could provide content :) Can you summarize so
> I can amend the commit log?
> 
I will :)

> Also how about a followup patch moving the rcu-tiny implementation of
> kvfree_call_rcu()?
> 
As, Paul already noted, it would make sense. Or just remove a tiny
implementation.

>
> We might also consider moving the kfree_rcu*() entry points from rcupdate.h
> to slab.h, what do you think, is it a more logical place for them? There's
> some risk that files that include rcupdate.h and not slab.h would break, so
> that will need some build testing...
> 
I agree. I have not moved them in this series, because it requires more
testing due to a build break. I can work on this further, so it is not
an issue.

Thank you for taking this!

--
Uladzislau Rezki
