Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CA31C68B4
	for <rcu@vger.kernel.org>; Thu, 30 May 2024 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071668; cv=none; b=Vcro2ISyQEg0z/aQX51Bhh/SwIkF5EyoQM5ixSCN/0cfeCRgkR8IlsZuYV8sOAsUWUZfeHSNQzHpDT4Mth3sCg/u5Hy+izKjPad0LIi7uEIcCw46UqfDLoiJ5n9rspxCCp5E5AhZrz19Xw7D/lImqqtoP2llJwG8KF3g5EdfRJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071668; c=relaxed/simple;
	bh=8HQgs2bIZJeSzUXXR37T/KQj003N1PicGc6R84rQ6b4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=j80bqxHNSHjUKfMzwnt/cvWB3yLk0Yr49sQZam8ixdY6q2DS/sSV7aQu0L8RIvGfnnwMnkGRliAuhJJjhxrEJ8rZYg6OXogdJ2X7H2BCiXsOCuwXdF6zFdmlKuws7iLIlstCENwxzVT9fxEDHYNaUqamVC6ocjJGRY31qzvYEnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xLeVl6UO; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xLeVl6UO"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4eaf5255cb4so183644e0c.2
        for <rcu@vger.kernel.org>; Thu, 30 May 2024 05:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717071664; x=1717676464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v1Y4EC+Vl3y/mxPDgl8+ARcytlJRa8bN9srCkIlilYA=;
        b=xLeVl6UOpgZyms91NDPZhq2WJixK7ulxAx46PSmUt08zV4WeF0ekxPu6GYj/qpfon/
         CzjP8Iu8RNgH3x/7tTjZJOB9p3d/mOyIpiEdvlMWwgRJSKKMFeW1geSSampTVKdMLZtv
         VcBfvah7+3V4RNjlCYP6Uolw4e0XxNdq7cLLetaFuw/OC+fzsPkSqTMBHvAiAxRObA9d
         VizgUOusIgD6mPyyhWAHdVhw5I5wNgSvR/Jcu1seSLlrsRrCrcC65oW//k94xQkSrhgP
         qHcs5+yHvIE+NrwelHvmVQWlU73rMD67H5tWLirGYwS/3DSvfb5U1Qf8qr89tbKXaOAo
         eCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717071664; x=1717676464;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1Y4EC+Vl3y/mxPDgl8+ARcytlJRa8bN9srCkIlilYA=;
        b=VmeHMlcrUzmCGmbll987nu53N/fWa2mZXHdg3W4nhlSg0tczIqRSYokx3chEuXrbUG
         Whe/3nrkE1Bgd6BA1JI2G/sSJeaIqLbJgSKYDwrD+NJo2au1/gFnu5HFODlfUHglIYgp
         jEKxqQrH4aMT9COJ0XjVIC11yiMtRwNwMHDXIzTputr4ZkRBFjpkei3nQUbqb/FnKTVx
         J7WfAnsfv5+LmY3b9UhH4qvJczSyfhMrF+fd/sRTpY7K8fIP21PJ19wjrxLxSJbSkUbq
         Ce2v0DzfoJyzO+EufC3Ff6wUALsk0MCXhbJXOVRR7qPrejAp+OyBNYDHWMW9iXqAnnhP
         dIbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/W8q9TrCtCUyRh4KyfIPj5/+NiN7GrXY2fnbc4ccmfFycM5Qenj0E2aJx8pCpPJ5gJdcXikb4uSryPA9KAXbQEISY
X-Gm-Message-State: AOJu0YyDDWxqv1FRTDIYGyaf4gmFg97eBrFgj12fJ2uSWE0Fus4l8l6f
	l/PcIEAIR40mNNO23/XORjt63xHnWBenrd7eXJ9kEmA3BEurxx/bFDcyK7a2tfbNFSXrquzq5/k
	dCaqVSGuoXwZOSZuI+TZlGfgVbRJSNI81vrvOJg==
X-Google-Smtp-Source: AGHT+IF8N1bqnuXOjZNpSTjG4359awFqoPkPrI5tsAypoZsac9kT1nKvP1mjv7Cjntk3JR1XaZe3bUmc9hbvrM4pRhE=
X-Received: by 2002:a05:6122:319c:b0:4e4:ecd0:fcba with SMTP id
 71dfb90a1353d-4eaf21a9480mr2299111e0c.7.1717071663960; Thu, 30 May 2024
 05:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 30 May 2024 17:50:52 +0530
Message-ID: <CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com>
Subject: arm-linux-gnueabihf-ld: kernel/rcu/update.o:update.c:(.text+0x1cc4):
 more undefined references to `__bad_cmpxchg' follow
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, rcu <rcu@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, eeraj.upadhyay@kernel.org, 
	John Ogness <john.ogness@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

The arm builds failed on Linux next with gcc-13 and clang-18.

Config: arm imx_v6_v7_defconfig - failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-----
arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
`rcu_trc_cmpxchg_need_qs':
update.c:(.text+0x348): undefined reference to `__bad_cmpxchg'
arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
`rcu_read_unlock_trace_special':
update.c:(.text+0x41c): undefined reference to `__bad_cmpxchg'
arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
`trc_read_check_handler':
update.c:(.text+0x4b0): undefined reference to `__bad_cmpxchg'
arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function `trc_inspect_reader':
update.c:(.text+0x1518): undefined reference to `__bad_cmpxchg'
arm-linux-gnueabihf-ld: update.c:(.text+0x1548): undefined reference
to `__bad_cmpxchg'
arm-linux-gnueabihf-ld: kernel/rcu/update.o:update.c:(.text+0x1cc4):
more undefined references to `__bad_cmpxchg' follow
make[3]: *** [/builds/linux/scripts/Makefile.vmlinux:34: vmlinux] Error 1

metadata:
  git_describe: next-20240529
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_short_log: 9d99040b1bc8 ("Add linux-next specific files for 20240529")
  job_url: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/2h944W0LTbtfMPlDNiOq17hXpQ8

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240529/testrun/24129266/suite/build/test/gcc-13-imx_v6_v7_defconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240529/testrun/24129266/suite/build/test/gcc-13-imx_v6_v7_defconfig/log


--
Linaro LKFT
https://lkft.linaro.org
