Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E202134D4;
	Thu,  9 Jan 2025 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736383696; cv=none; b=JID1SfjCFrF0eZZ/+t14hV+u7ltvzUpWJmWe2hCFKQ6Crb4iRYYGvBmrRONbQrdFr/1/tktAU5bLNbY8nRBoj9UzbtaDD2R6yMQ/NVmpWz7vJmzIxl++VDfFuSzjgz2B5Kna5G215Cs416QOOfbhCT9oPcLgD0LbI2M+fMcP8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736383696; c=relaxed/simple;
	bh=UTuK1ET9XQGZa3/MVdgxzIMNqWBAR72e7i4jesPKTjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfsqgOiM/T8YFGptQ7ntdhYXcWHA43Mc92v3yWj9W+x3SrkHzudWxRti6iZFuv6avqOLnWsV45bRfSW/qGfjpIFvjZwKCeZ2dEPLA8rqQ0Yf4tn1bKhMQi9JtYrRX5BSJDlLNZQ0HRkjx0Xa2SZCnjrjpTTiEXrMtLElZJN0bp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9GTBXk/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9GTBXk/"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2163b0c09afso5088245ad.0;
        Wed, 08 Jan 2025 16:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736383694; x=1736988494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AyRlsdedwl2MaogRWxSb85Uoe0+So/PPTlWho9VOgYk=;
        b=h9GTBXk/ktVPNe2FQK14iwM7AZ3x32qfc3vpbkn9LM0arjtXI8u0qvBRPkueFrzEVt
         q/WhOUwNmRWOB5zrjXedt7cHEglQauMw8fIJ7wdt2pDE+futdjzwy2b9N9UJhS/uilQS
         DNGocIbPW7DP1GwN7NBlOyJot2Sa6B61Z0DtHs/2Cd1f9NeToLMRY+mbch8aucjm47oR
         donLgwa7E5Ml/XPZwDPtyNEXY2GJfJ8GNpFQVDLWAkx0RUS36x7IdkQozF2eqhspJ5pm
         aTc5rudbXBhnDA0K7bzpsGodhNXGqjTV3NHfli6N5uOODQW9yCvdKZt1dYIS2rMpCLPb
         kYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736383694; x=1736988494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyRlsdedwl2MaogRWxSb85Uoe0+So/PPTlWho9VOgYk=;
        b=lB5h8IUIgEFAOCUQwEFvduEaf1e0ZY/WtPHVqN2nU3E0brA3FpSYxKeohxWlpxVXGL
         lzGmRiO1fddogkoiC6tjFxwb0YUGPHA+aWptOZ5yYKfFcZVVrGTO4yHQwnx9Fr41FrVN
         8RdKCid+PA+lMBnQw1DXQIJi0flzhAngSbu7z0oIOVfAjp5jE3AWCr8hJ8iOm1SlK18A
         rw5Md1P57Y2zhcvy2U15r+3KZ/NZBJHcmYwwNWb2hRbHpwFnByCP+vMTotJz1Z+5ze8E
         gJbKrXMw+Abbq4dVnFzC5vY/DTzGEGqpDti+z4bNit680JIQ3mKqB6r8sYn5KwmCYyro
         3bGg==
X-Forwarded-Encrypted: i=1; AJvYcCWsC643DcxL+GuVcPJpLoAiCSggmnok46lfO1dP6LCpOxBTqekZ9yNlP55mF7ylK4pfaObz@vger.kernel.org, AJvYcCXnB2ucMLERzag9YgR8DyZyCJe1HVXsacjYran/wXxmJ+H/SnJsEaJpQZtMnCoLOI7EMcxAyoJ38JYzImQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyP4OQszAT5WWPPJbvcPF8iv0N7ES6ZMcsZApQUAEdHEkVa+6j
	CdOVW9I4RCsd9h2PhazmbWbaI7VJSt/vPATsKIdqtBWfvhfdiJCS
X-Gm-Gg: ASbGncui9Vv65a2Z0ilwx7JVgrjZMmJwZ7ubqakGcmAtawRNy6ARtnCAGh4laMOIhm2
	jPB/hDm587C3DtcA4Nb1pTIHyszdoNwxqMIqDg9DfdX2QqoKQHIrj1zWQe71V4//ZCI+Zk7N9SO
	b/DLcSKHMe/DnHDJiK9UJJDnn88CcOtWlAyHhd3mSu7mWWakeGDAWOP/rBjuCKNWMG60kHykaX/
	aKwFKXbKriCKVQiWvYJZJBfPW/DnhOR9cY94tlpF51PyRQ3nKI1pYM0pdBVTT0Pi2/4jcc8ilFu
	GRy6ewKT
X-Google-Smtp-Source: AGHT+IHOASRsPusiE1/dt6i63oKr3Y5J/KVkYWl6DwsIKYJqQGPpqdW4mCeL2n9KXKTpQ7gklVKp/g==
X-Received: by 2002:a17:903:41c3:b0:215:9a73:6c45 with SMTP id d9443c01a7336-21a83f4cc87mr85258345ad.22.1736383694431;
        Wed, 08 Jan 2025 16:48:14 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a91767287sm597265ad.38.2025.01.08.16.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 16:48:13 -0800 (PST)
Date: Thu, 9 Jan 2025 08:48:10 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: David Reaver <me@davidreaver.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	"Paul E . McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krister Johansen <kjlx@templeofstupid.com>
Subject: Re: [PATCH] checkpatch: Remove migrated RCU APIs from deprecated_apis
Message-ID: <Z38cygMTFuNigafF@visitorckw-System-Product-Name>
References: <20250108192456.47871-1-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108192456.47871-1-me@davidreaver.com>

On Wed, Jan 08, 2025 at 11:24:54AM -0800, David Reaver wrote:
> The deprecated_apis map was created in [1] so checkpatch would flag
> deprecated RCU APIs. These deprecated APIs have since been removed from the
> kernel. This patch removes them from this map so checkpatch doesn't waste
> time looking for them, and so readers of checkpatch looking for deprecated
> APIs don't waste time searching for them.
> 
> Link: https://lore.kernel.org/all/20181111192904.3199-13-paulmck@linux.ibm.com/ [1]
> 
> Signed-off-by: David Reaver <me@davidreaver.com>

LGTM. Thanks!

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei
