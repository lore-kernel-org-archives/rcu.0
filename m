Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3026C1E885;
	Sat,  7 Dec 2024 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733592845; cv=none; b=BNMzP8VHjhCv6sNUiC80q8xz6km+khQmXh3fUoszSxIuS3A+1ObrVQlWrlyRAcslT/277aMbVdEbNMkxGcfPa/1Xlq4PLn6fbncKuYdOQy1eWdU7U9pcBty3O6hj6kqFqaS9vxo8cZttbRKh16+Qw5LrpEI+gWRuKgNYRUvmraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733592845; c=relaxed/simple;
	bh=sXgGpJwmCWh0+j1kP+wf1CkKqlu5PCqYtFnhoMZDaZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwqP2gGjRsMAhyz7z2T9UTlbekKx825KkyQO1l/lU6Q4G3K6TZXoVzI/mOkcavGiHikktkIcQd4MukcUEJ7XVq4lRaepbxe3dYH0UgmIWThLX6twPVmhhnefxkLaOKY5TQOiwFujPynA/7o1Hr6fYQXGiTRBfRFVBkKp1gqM2HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWu2KHWH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWu2KHWH"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3e829ff44so646954a12.0;
        Sat, 07 Dec 2024 09:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733592842; x=1734197642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sXgGpJwmCWh0+j1kP+wf1CkKqlu5PCqYtFnhoMZDaZ8=;
        b=fWu2KHWH/hDD5lSOaFPn2SFRycmyjsFaSPVmDx4GcZzom8TYkmz10vPdBFJ/asEN64
         k/d+xXW7YMvnDhkNiMtOSFr/tYXLD73W7Bh42bSATouIqXIf8uU0VdbfLUczuKLiy8zo
         9sVYhQXdDfg76wpP2PrQMrTtYosAkuibYx1bnP0//Cs1L7tAurL7Wq1hCP+1gBMZVPtV
         qak4+Hpp0BIikwd+yaDM7wwiBQZs7jyzmG3n22wiLnI+HUKGVgCKQPprmXfA+njsbS8c
         iFJU33X/7gSygoTQJSKpqj0eNSlBbtcy74lXOZM0Qb0bgdYzUkGCEQ1LDlNCY1Z2nT9E
         ykxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733592842; x=1734197642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXgGpJwmCWh0+j1kP+wf1CkKqlu5PCqYtFnhoMZDaZ8=;
        b=ZpkTEJ0wgu9BTrFGK3+46G2Oo7Dvmidq81WzGKZPYwvkMc/zR/Hr3Jq2hDYfudfl/C
         sNtUTkxh9kKsbChvIDYWQUUf30SfT1stf22n71REso5iWgAlR1o5lg7o8Iwsyryu1/vH
         SMXZQsXZTRdrmmFFBu/M31mXIyUIAocZ/4UoJnrMm4sjdzBHQlwMKjbtSXz19c9ltfbJ
         8QIC18QGP+fRPaqFJj/eOLtpSi4rkDsEpckN9NWVjblUM/+Rv3tCEuFHbVU9M6iYy8/x
         ElhHu9IoCEL+wx/0sOquHJ2xfAp2Tpx0M6htX2XIXGJWf2sg6HFLTV90qL7RcBSr94Yg
         H6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4DwmH74tbWvi4bZDYSKHznftsglFXiUulPfln8g/GFdVslIiPbOUBqwLgZPFARziOW9JKIJ8joKZ6tg==@vger.kernel.org, AJvYcCVfvJ0OaTfAc7cTC+QMJRAgO1QLnLd7oq9HGNeGq+HYX6DKe1MmESYfKSpsBS58jjRO35dZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8VjqWVM/Izn8+3gjb1b89GgMSpC22n9hoDEjZ2GeKof3yu3gT
	JoIh7M7pYyMW2qcda1P6tGWh8A6JOLL5mvXkNespy2SnPw09OGkv+OK1K2sGEiKaGR3rwJtI7OJ
	Uy6sZh/9uwPq9d+PLsOiFFgiH+0I=
X-Gm-Gg: ASbGncuEo4RaJW+BrdivdhEUAFPGVfseaVoluldpxWcDqOzMlUMd1XtuhHVzEQNL9WX
	fmv1RKNgECfpqe5/F1uUNqeMoDLt8q9KH
X-Google-Smtp-Source: AGHT+IGCt15yaa9kTeg6DSs8G7LdF7d0JBxotRn6409Atqy4Dt3NdZ8T0ciX2gjnDLDzgnNYLIIx3wkvOaPMfN5twF0=
X-Received: by 2002:a05:6402:3216:b0:5d3:cd9a:d05e with SMTP id
 4fb4d7f45d1cf-5d3cd9adc64mr6065136a12.9.1733592842273; Sat, 07 Dec 2024
 09:34:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+=Fv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=Ei90G98ukRcRJA@mail.gmail.com>
 <f1561626-fde6-41c0-9d45-87a6a7b13816@paulmck-laptop> <CA+=Fv5TMZ1bckob2VZ1AaNwdU3R+5a8REKg4aZR8novx7+dj-g@mail.gmail.com>
 <8e365392-0e0d-4d78-bae7-69f27c8350f9@paulmck-laptop> <CA+=Fv5RKEC6Vabh3bnJfF7D377qL0PTNkWeqSEWqK9DE5GunrQ@mail.gmail.com>
 <51ce38fe2fa34ec79ad07a96feaea597af07bac7.camel@physik.fu-berlin.de>
 <CA+=Fv5RaMF2ohojG+U0MG-dpLHS4x-Tc41+fOLZwrWqu7T0L0A@mail.gmail.com>
 <CA+=Fv5QH1nUO1D1=Osqic6mNN6vLxiLqvNA4D9uAUgZA_w+7Tw@mail.gmail.com>
 <0b338882a82c3f505407cb313b89a2c7f891d982.camel@physik.fu-berlin.de>
 <CA+=Fv5RDcgm4YSX1AcpOgLvL=XXKyA=71ZasbJSc7+79Kh_Xpg@mail.gmail.com> <d9330edfca0fb34c69a68c56924fa0b074b26d29.camel@physik.fu-berlin.de>
In-Reply-To: <d9330edfca0fb34c69a68c56924fa0b074b26d29.camel@physik.fu-berlin.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 7 Dec 2024 18:33:51 +0100
Message-ID: <CA+=Fv5T9nrQjGHOR+42tfgT723TJGgyVqBY7CwY4L-gYSoWTag@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi again,

Just a short update:

Regarding the SCSI module unload problem, building vanilla kernel-6.12.3:

alpha-linux-gcc (Gentoo 14.2.1_p20241026 p3): does NOT work
alpha-linux-gcc (GCC) 8.5.0: Works!!
alpha-linux-gcc (GCC) 9.5.0: Works!!


Regarding the network interface rename/rcu_expedited() problem I've
tried gcc-8.5.0, gcc-9.5.0 and Gentoo 14.2.1_p20241026 p3 same
results for all three versions, even though the fix is similar, using
different compiler versions does not fix the issue.

/Magnus
