Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF581C68BD
	for <rcu@vger.kernel.org>; Tue, 27 Aug 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773188; cv=none; b=R4YCNb93VzhVcsC1Hr7lNnypDp6unXuugPm+Z53lrw5gJ1e3xOOnaz7/PGEsemD4BYYSTvtxSHbWaCmESld3H7+IjRrcpl9b5UtW4bHVnsI/njPG+YwMoLpmVV/bud2T+DXlzYAmWXJ3dMUg12ehz90Oor/WGkDeWSlXHl5FUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773188; c=relaxed/simple;
	bh=J8i0Lb2oWbc6JBapK1BY0lUoCq02D7GVagTSdbkqv1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hV4VQaq/PRgGKDGTTdjD0MXfAqSQCisPwQzz+o5HTJnuQGqaHYyvrLN24ycIi7DuaiBbwYAoHgypXB3pRQ48AqAzhgJLvyq+GLxLVBEUcUntOlKsSuI3LxTttSNmvE/DQ4ju2vKA+5y7uhTIpgHYg0s1u2u706Im2F7nsyhSL3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cshmBU59; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cshmBU59"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7091558067eso3369111a34.3
        for <rcu@vger.kernel.org>; Tue, 27 Aug 2024 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724773185; x=1725377985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ABrGPaQeXTHEpHj1nG5eL4qDwA/TNxf5sECkQr9qYBQ=;
        b=cshmBU59B8Y5XavgvLSrMfF/g+ab0w0/qNjaBmPn8DOLpyzD5OfHW28NZoxO+y/oTC
         BrJSIy0yTwDQX7gSxm81rMLhIk1MTNjXSx51UHSRZuE8VxYP5IE4EeJFMOL4FR2/51jP
         6fejy1vw2Q1cIQz3hekKQqAjtD2xRdcfl0IdLNyd/fJVP+6hLH9D2bDNJFicZvbFF/b8
         jlxBTQdCHX43+sQ/2rGVN1RH1SY1RJcYYrwV1WQl+wdrAwGiEiVS8epmlrjbWSFnOJHe
         w/P9zdhuWd4r+18VLvYdph2jW4Ml7UYQXD6el0w4QvHnNdGBN0Y/NKFShBbs03paQD++
         dwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724773185; x=1725377985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABrGPaQeXTHEpHj1nG5eL4qDwA/TNxf5sECkQr9qYBQ=;
        b=NHEv7VzwiUf4gzcmwrgPS8Y5FmmQ0055jGZeQKGslasDCIbXB8D6pyJdMFqusbSxMv
         Y5UMYEv+oUMUBrn5TYuln+n6OIaUOuWyJffW/v/uURTP2G7rrFjv9yO+W0tPBjND5Lxw
         7nSpr0Gc08jOkCAbF+eFRA9pnJc27+gkrT0oivRyWFyJVUKfSrWgVXNzkmejEDKaY9NE
         8+oF7PuFrf5kP054QhmC2Yv0Hg/jISzOCrzjqqutRspYHhaXuw7Ovh+5awpqpOg9Z/LG
         VqrDtfzCtigEAEdcFODkXQ1veFnTXXDsnlGO8ruGphhFM2V0H9veTEtseW7dciLRn+Ya
         co4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuwxZgvvaCYDwD+oLX026dK3CFOzJIK2M7tkFPymvHQRRntePKsJv+HlwiXnkj4+Cwa/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvUtjRpsK+2OHyz6IMbxWIUHxzkrf724OQ4l1AmkQlnk4VSU6+
	UJ/bxIZntpaBRZIsDHbXlH9JjkA0umBqTUBMYo1EEKbZJ3A7sb3ePMCTmLF50LWk6cgB++FxkUK
	97TvRZW4lpvV51rMkuzDU4WFiIWPeB1kofGmb8Q==
X-Google-Smtp-Source: AGHT+IE+kcBunpFXfOGpuNdas/X5FdTgaWsUmcSrsoP0VkiG4IG6IRfZg8+GgGc5TZDGinb+7wjme3MyFaQZ0qKWfPE=
X-Received: by 2002:a05:6358:430f:b0:1aa:c49e:587d with SMTP id
 e5c5f4694b2df-1b5c215d7efmr1740185555d.18.1724773185173; Tue, 27 Aug 2024
 08:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827143843.399359062@linuxfoundation.org>
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 27 Aug 2024 21:09:33 +0530
Message-ID: <CA+G9fYuibSowhidTVByMzSRdqudz1Eg_aYBs9rVS3bYEBesiUA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/341] 6.6.48-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, rcu <rcu@vger.kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 20:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.48 release.
> There are 341 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.48-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The tinyconfig builds failed due to following build warnings / errors on the
stable-rc linux.6.6.y.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
-------
kernel/rcu/update.c:49:
kernel/rcu/rcu.h: In function 'debug_rcu_head_callback':
/kernel/rcu/rcu.h:255:17: error: implicit declaration of function
'kmem_dump_obj'; did you mean 'mem_dump_obj'?
[-Werror=implicit-function-declaration]
  255 |                 kmem_dump_obj(rhp);
      |                 ^~~~~~~~~~~~~
      |                 mem_dump_obj
cc1: some warnings being treated as errors

Build log links,
------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2lFMi7HOL2XF8hQWViw6CjE3NAF/

 metadata:
----
  git describe: v6.6.47-342-g0ec2cf1e20ad
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 0ec2cf1e20adc2c8dcc5f58f3ebd40111c280944
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lFMi7HOL2XF8hQWViw6CjE3NAF/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lFMi7HOL2XF8hQWViw6CjE3NAF/
  toolchain: clang-18 and gcc-13
  config: tinyconfig


steps to reproduce:
------
# tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org
