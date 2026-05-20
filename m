Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CC6344DA4
	for <rcu@vger.kernel.org>; Wed, 20 May 2026 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285249; cv=none; b=MwvPfrHxgrB8ArgWmLbOYSJrsxWf2L0d3XAcfZe8AP4w747xl6HZl6f80s6I5bP8eBegHvOg+CNKN++Cou5rbaZRy/qK0VULyHym9HuC8eLqOIoL2LzcEXmU7QIhEqIqGzEPzLP6ASjcG1/QYqGkSKuKCEkjpbXYYv9lpE+TeKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285249; c=relaxed/simple;
	bh=DKohWiiNMRUCJH+Q7E6FflIYzDHqeppmsRU9EzVckqM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6JPzLcWWigiEoUTOjaraDG/V7FNOcvG74MTtj74uw5V9xjtEveg/DEr8t2x6lcTXe79B96UVEsWL0GMHqCre7ArgElWt8uBQI/GWchgk+e84rSbQpEW0+9f9AtfqONGY/mYM4jVplYn0BQveHKHZUKK2CIljphdNmQMBhGgqCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyyBVBo1; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyyBVBo1"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so5353172e87.2
        for <rcu@vger.kernel.org>; Wed, 20 May 2026 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779285246; x=1779890046; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V9hgJ6h69w+t3jbRa2NQYpO16TuXoHhIo0EX4Qr9Grc=;
        b=hyyBVBo1LvEDs+lchy9IRbblSVRUJtO4+eDenIIPEsWIwmgXHYQflvaF8Q4ikRSTGt
         xzfkCdX8/lwCiwStk9VUMbRE4DkVKsLyY3QXxu0kH/Sdo6HghkIHh9ztoQB6wlZui+O3
         WIyoHnVJH5ArEtpeQwGIw9+hQ3WSJ/XwaGk/dzsx0Y3Xgt6SEyD4I4voAjx0GeElObFh
         bau55RWZEE+ujcSBlLSG1XDN9boXzFTdOJ745dl73OnVDP/WNAdavSv8kr+JHqlRXv3b
         SE/rJwMd/2W2Ql7aV05+sk26Qv1xTSBotiTVrNctUYrK/+BYlP8DL7/8ly5WTncUhC6L
         TOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285246; x=1779890046;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9hgJ6h69w+t3jbRa2NQYpO16TuXoHhIo0EX4Qr9Grc=;
        b=UcdzPqBNUvleozrIxTfSwntu5EoTiAED0/ZBczarQh99CsMP0X9SZdn0mNKMJW3MLt
         Jf5W0N0fLlUqXafuwGcniYqOIDE1V5iDPvTGnzLQbXpTPN6x837kP88v784TGWsfJtBk
         2mIABV+QTdgYU0syx21xAPdplCbP61xDFWCtgrUDIUeuho+wgiqLUu68fe0WAd6nHYa7
         wYuVpv2NLMWV1ykcE3BOGx4gTlSS2y31WJxMTeL7B3kWCfsWirtJOR4ySSeTNGdX6Qxc
         Bw7mOCNVh5KzkAed8z9dvjMMHNyOKebQHpQxCB/NPZjeALhQ5aN1p41yAyemstvIdAFj
         SvWg==
X-Forwarded-Encrypted: i=1; AFNElJ8EIcT8c04iHi298MFeORBymZzD/uxImFUgp23IRKwXPutxzLTHiR9SVnUQoQb4QlgyxIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykvV7sykSPi8fc8R2phYRIAPNkQ2vJguZ4fJyNvExRAPgEKaQp
	IaLVQVj2QKmytfrtkZN+m7KZRZr/jnEhRJJkQXt8uZX90AcU3w6KVSeP
X-Gm-Gg: Acq92OFYPOjnVLiP6Snpiyrotcfe4TOg9d+aeS6C1VFuq981zUOb3UlHwKumn7l+hWh
	ivmdBY9b88D+ecKJ1D3+gZq+lWlWeGbBD73Xz2hRSxUZ+Zx83qr/9N6F3RyiLtN/QwIQ+22S/oC
	nh9DAE8HrXF7alzH+p46ls9EOkBMj6iKXmqw7TEQTeqiZZbfVDlnT98Tbg2il+zyeAu4VdLOuqv
	x+CMstNdhF4b9HZAZ//YUSDK9kdGVfjkmpWN9Yzo/wCqZTNCawS38SPK1quKXNbve5e52Qj93g+
	lx0xmCc3DsGoWsNSjbzi5SOy33gD4EDSSiMpnXCMKwbnUKDJeD4GYzG5DvJxwMa5bhQmeG4PWg9
	4/e935NBcC+xWQw2kOtW4+jXjZx6s/3OeWIrROTRBFQ3K1U+sqFXs9Xa/Hvro+Xpjs0Pt35myIj
	8B9AzOTuK3TA==
X-Received: by 2002:a05:6512:1291:b0:5a8:64fd:142 with SMTP id 2adb3069b0e04-5aa0e60aebdmr7643865e87.15.1779285244557;
        Wed, 20 May 2026 06:54:04 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c84dsm4965501e87.10.2026.05.20.06.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 06:54:04 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 20 May 2026 15:54:02 +0200
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2 07/11] rcu: Simplify rcu_do_batch() by applying
 clamp()
Message-ID: <ag28-oiqpg1Y8Kcj@milan>
References: <20260519194524.158515-1-urezki@gmail.com>
 <20260519194524.158515-8-urezki@gmail.com>
 <ag2oh3MNOm-GTWLs@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag2oh3MNOm-GTWLs@localhost.localdomain>

On Wed, May 20, 2026 at 02:26:47PM +0200, Frederic Weisbecker wrote:
> Le Tue, May 19, 2026 at 09:45:20PM +0200, Uladzislau Rezki (Sony) a écrit :
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > This commit replaces a nested ?: sequence with clamp().  This does not
> > reduce the number of lines of code, but it does simplify the line that
> > it modifies.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
Applied Reviewed-by tag!

--
Uladzislau Rezki
