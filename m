Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337F13A3F2;
	Wed, 11 Jun 2025 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633854; cv=none; b=fjN8CCkEmqh3yDbaa6Y3Og/hE2yyXnftw5W1KhDAJoXQahrs4Nk97N4ZUPzFC/JtLw9zB3f7vWmOPzzJ/hAu+UpLPNhw2roG5Y+H2LBgaCKLBRJ6x8htkeCpe1WokVZk3J/kNNDptNUrhV/4DgrdLrRviLgRBz/H174rXtVdWZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633854; c=relaxed/simple;
	bh=5/8W840tPmjAOSicEGIkPaRY7wAxw1598/pR4uGMdPI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWeMMxdnlMPRf9ffvIrzYHNgE5SSFaIuE6EugxsETxD1n7M/PmghmZC2+yQ/FSR16AixwUZUz8gDIdDxlY5MOA9QWuar6fj2zYk3OZbrPOysrKJDH8uGbDZFe7hErc2p5XhKVFqU3fyEp9wGghagU5NkPFrwk0IPxw8mzksjFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfmfIWM6; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfmfIWM6"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54e7967cf67so6683505e87.0;
        Wed, 11 Jun 2025 02:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749633851; x=1750238651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ooxsweVhxDZk/MiyOw/rT0MTdCnnP5m+DT+6M9OUp18=;
        b=FfmfIWM6wTjFILxwJr+32xBQLWeHWBU1LcDFlx+fjraHSDBkQ3YScHy5dmjgTkNJ/v
         pudcDV+ehX/Bbz9Kea6LH/0PlAUBsO9YW85QIOv0NT/abV3IGgjjGt8ZQuyGt8hRWr/z
         t/9UthEBPPfDIfgyyi+VMBo5ohI2qSK0FVQ4NfdUQanAfMkBUds2KU9iQmt64aRKDalT
         RH6kkpc4qAE9nleyofp2+O5gnDQo5NrkAKpLdzHo7ijgTIlvw4TOrYyjwXou0IRw6zd0
         SCmYCZZLcY2IF1PhG550yuBIDJNdhXSD7/vs46hn25eJlLJvbWIrlFkk9ame6wHJbJDh
         rYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749633851; x=1750238651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooxsweVhxDZk/MiyOw/rT0MTdCnnP5m+DT+6M9OUp18=;
        b=sfinTZZ+y6e7kHl3Z5+IsQsPeu83wRAjZIL32AUTjlTXPEh230UTfNLu2SlX1Siavv
         /+7HcO1wfN7wVnLKth6UyyuKvK+8vqP4cVf1bmS7kPBxg/jZS7rFS4lavjmfYXAxjvDl
         HPFMOOYlAoRQLANunlwYGjFlMOv4PWDTLm+cdDn32+JaD336dNmMwMkddrmAx+b8sYTC
         YNSgJilhhHC9NtYAE5Vgci3VSlLHs/VeWH6s6g3ETFSZCjIQTYGSe2UuRz8jhjcB9LfI
         sL+dkzR+F8q3iJb1I9Xze+ujUpm1jAWDY/Re7UceSX2l1MXqb6SYiZsg0HmILHx68Qwx
         k9Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUb6wsNt7HXLUUGF83glIKVpylds3vktJdedCbBGhiD110hzpUFXAjBumZ/bK3M3cgEWIFm@vger.kernel.org, AJvYcCVLnbjxuxnn5ZlPyFcAnqcLs95CW7ImrJB82gsOG9hsfmklHxHpfgVgdEiQzXQtoLvj94wVeO6J2jN+4Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk7g9DZPOOT3alJ9X+x/sKRPb/8ex4paz7o4XSy4HbqqUNMm4M
	Ty6SJaBJP9VP2fbFkV3AAyIVP14XU59wkIg3FzssIT6wa7nWjqcile1M
X-Gm-Gg: ASbGncv/JpkjJIakHt6VTWpLLaAq3+kGRQtAKz/OxvQjcmIkN/ooXOsf07dG3tlmGv/
	FseyOEn2V8UQHvTsJh0ULYVeuDmBBYU3cbAGBchEZbszuhGeP5xxEurXKYwukJtQ6AOHNiTBcqI
	yypLmK98zgOZXh9GLEMYlhzOEBMWXz456OSGxZH6Yf6vyI3xDXHIOZwZXf5s2zsp+nziUOtwvkS
	ps9hx92x3L9hFoqd04JqUH51FDaePeeDb8YryxG4yFSreALyCYpIZ2vxF+SBYoOi3HlakhXf/vQ
	BBiRKpS5zdVNikZsFvdRLFPSmMxvz9pEei17VpGr+F7g7w/Yy5Ev7VPA8LNu5ofo2cGwllPo0Ev
	IgFRd3qNLpUAmJTYhHxQ+Qg==
X-Google-Smtp-Source: AGHT+IGMzLvQOIpMlLk5MdUAHVIhxzmdf24EVtAKrNpIrpT+YxMAV5LC+4Rw3GV4Ui3kqi7axsDYLQ==
X-Received: by 2002:a05:6512:3e06:b0:553:302b:85a7 with SMTP id 2adb3069b0e04-5539c21cd85mr790262e87.28.1749633850562;
        Wed, 11 Jun 2025 02:24:10 -0700 (PDT)
Received: from pc636 (host-95-203-1-180.mobileonline.telia.com. [95.203.1.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553676d78casm1892152e87.66.2025.06.11.02.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 02:24:10 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 11 Jun 2025 11:24:07 +0200
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/3] rcu: Return early if callback is not specified
Message-ID: <aElLN5GD8FA2zya4@pc636>
References: <20250610173450.107293-1-urezki@gmail.com>
 <4bc63cf3-29a4-4a64-be65-30f7bd55e31c@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bc63cf3-29a4-4a64-be65-30f7bd55e31c@nvidia.com>

On Tue, Jun 10, 2025 at 03:33:32PM -0400, Joel Fernandes wrote:
> 
> 
> On 6/10/2025 1:34 PM, Uladzislau Rezki (Sony) wrote:
> > Currently the call_rcu() API does not check whether a callback
> > pointer is NULL. If NULL is passed, rcu_core() will try to invoke
> > it, resulting in NULL pointer dereference and a kernel crash.
> > 
> > To prevent this and improve debuggability, this patch adds a check
> > for NULL and emits a kernel stack trace to help identify a faulty
> > caller.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> I will add this first one (only this one since we're discussing the others) to a
> new rcu/fixes-for-6.16 branch, but let me know if any objections.
> 
> Will push that branch out during -rc2 or -rc3 after sufficient testing.
> 
Yep, that sounds good to me about rc-2/3 releases.

--
Uladzislau Rezki
