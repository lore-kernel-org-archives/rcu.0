Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495D712A17D
	for <rcu@vger.kernel.org>; Wed,  8 May 2024 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189893; cv=none; b=hYSv2KOiZ3dn79/Y1NqEOMrugx9Zv347XxKmJSMfydhBj+NW95eefDeZgZB3nDT4Ad5hXTX139tPa7E7V2R+20sAcpuzV/SuQ/ud6F1f1MwYKLbkbbqF/joKlajDlJOhYEEBEekk7Zyrxoo9eExmu5j6qfte61sZaMaXTfj87OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189893; c=relaxed/simple;
	bh=qLqkJ7vbYlXoF5p9IsLuLIjK86ZU5yNUOyIaZ+74ZW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovGBiXNA5ef32QyqOS71Nj0MhTc9T5OYP4v/fx+CG9LI6f4VyfoQK8w1SvbRd/AKNMF9IPRdAY2RwpXnq+qNwNWF6rTYaCRfuqd4d5GWIvPOdmU7g9lDUx9/7SCUKPDgith7JugoYFfSSXPvoKkU0ZUBZUbOWK1GwTBms5kwtE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lbGuU9Ep; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbGuU9Ep"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59cf8140d0so947698066b.3
        for <rcu@vger.kernel.org>; Wed, 08 May 2024 10:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715189890; x=1715794690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gQot0/PkPori/dKh23nmNQqVvgxIkIrBnc3Ax9zhrcg=;
        b=lbGuU9Ep42dE7VK8fj3SBj65GI/WbVFNOBrdVwlTHUBArzUgtP26kQ9QZDYkLvA1v0
         IjCj6UNJkARsDQ/oYFs2011iWjWzX3Nhx2Q+aG1TTCe93L30X9XLe4G8QgIXlrkMP3Vm
         P1rE17Hez2nUpQPx4x30RIApSGp3S1M80qGdsz7ETD/ybH8vC3kK6CARkQ/J2DMHwsKt
         7n3bvZkyDu+yDA2wiCmpHQBZuoqi0r+0Y4li+6lyhrOICu8sH8U3Vty0mE+nICjdtQZ0
         5jcO3ohx7/BTvPqRMKjqnuMsyBrxDUc28UrEOnMeu3QUMCEkRjDcj/ysDzZ63bAHdN7v
         8mZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189890; x=1715794690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQot0/PkPori/dKh23nmNQqVvgxIkIrBnc3Ax9zhrcg=;
        b=FO0EL9/VyXi6y91sRP/zcFM/m70WF5kDy1x2DkxNpxKmJLs0jJAlcb+1KTqwuv5Y6P
         hLfKo/BNPzpQMsgU4tCLOOeCblekRgeCRyMTUFH9k9htsm+qILO5fJ/HboRMO1dVT+HG
         gV6cmN2ZQXx6Ivsnb36lyhHhwmAws3g2vF4+5IniuwoOq0pL262OdfJRdW5uzDsPmxNN
         8fqGdiNzp9X1xMAwA+yspxqEZ6c0jwuEpx+4CPxxFvfos1zZ0xojsMd0FV5iY+9lEukl
         vO1u2jcpBWexui2wu+eTziTLzymbx2c8ZNF1v+UUefPlNsOLWifuK0IzIfzgpAkXzwiY
         mFGA==
X-Forwarded-Encrypted: i=1; AJvYcCUSdZNipTGs4e8bSHnp5hI1sP3rCUTD7MQU+i0VXV8kQBHXaChEDfvVq/E3boJi8ncBWTHmsr0x80NJN82LSiShA481
X-Gm-Message-State: AOJu0Yx176iKmFqynEzaY5vRjYzBrqJhv4/8UBGccDaaNpJkRI09CD9C
	A5f2KrAymo6O9rhzrBlY2cZ0262gkFAZdpNfmvFLyqxbWGm/8GBRvcv0Wf6yb9S/VaiV27I75Vr
	3
X-Google-Smtp-Source: AGHT+IGqeKoQKVAuJmw98o+dFPRXgEZ7/MR7ovgg47z7/WdPzgCk8x3UD+/98HCJx16qDb3HJQr2oQ==
X-Received: by 2002:a50:cd49:0:b0:572:9bd2:9a90 with SMTP id 4fb4d7f45d1cf-5731da5b696mr2398595a12.31.1715189890417;
        Wed, 08 May 2024 10:38:10 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id w26-20020aa7da5a000000b005722cb1dd6fsm7717208eds.27.2024.05.08.10.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:38:10 -0700 (PDT)
Date: Wed, 8 May 2024 20:38:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: dwmw@amazon.co.uk, rcu@vger.kernel.org
Subject: Re: [bug report] rcu: Kill rnp->ofl_seq and use only
 rcu_state.ofl_lock for exclusion
Message-ID: <2a5bc6d1-c45e-4cf2-81bd-49b55caa1478@moroto.mountain>
References: <febb13ab-a4bb-48b4-8e97-7e9f7749e6da@moroto.mountain>
 <cef46486-ac26-495d-bd2d-1e998a73a421@paulmck-laptop>
 <edfea2ff-d73e-48aa-83db-96daba77c500@moroto.mountain>
 <e775bd83-dfa3-4f09-9539-e0e655feda08@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e775bd83-dfa3-4f09-9539-e0e655feda08@paulmck-laptop>

On Wed, May 08, 2024 at 10:32:43AM -0700, Paul E. McKenney wrote:
> 
> Agreed, and please see below for the proposed cleanup in this case.
> 
> 							Thanx, Paul

Thanks!  Did you see the other warning I mentioned?

    kernel/rcu/srcutree.c:910 srcu_gp_end()
    warn: mixing irq and irqsave

Btw, I'm mostly sending you these because I know you're interested in
these sorts of cleanups.  I didn't bother sending one to aacraid people,
for example.  :P

regards,
dan carpenter

