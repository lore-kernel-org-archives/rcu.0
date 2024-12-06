Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EACE152160;
	Fri,  6 Dec 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499589; cv=none; b=Qdu2Jy52SYV06JFWGjYQ/aS1Fj99+OyiDzi0VBocrvw1+Wsxv1CvhJtJA5FCdZRP5traHnGWVAMeZFmHmXa1GRyUEiedH0bK2MNGeO6rodyHWu47aEVm0xMgG7ToR0V6YRnjCwhlCYjG2DZxXCPBLhL4tBIVYTez7ZBdF1nF5kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499589; c=relaxed/simple;
	bh=6jF8gQsmcoDk6nnY9ak6uOJVKTXH0GqbCdgHR4en3gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skpuKzwiTwh1v8/nI9gqXE8roNEqGTY2o5zJBLSzJOniw3Zeh5aJjvdf8LFkLa+lWXyIcCGZmh5D4cgUipRmyeLi02RcYxxnNcrnITbbfmst/iOaUiGk3E1QO2BuMBIyboOzmNJPnJvQvJxh6uy3mIb8ouUsaSRjxv7NtNBxRSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9pdTqwJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9pdTqwJ"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so2438386a12.2;
        Fri, 06 Dec 2024 07:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733499586; x=1734104386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lQlRSa0gyevRYdEMWu+y6kaDOfqLX2SV11L9Osx2Fq8=;
        b=P9pdTqwJ+Uwh6cfab08L67SGSVBGuIO1FcE7W35zX6kxMX6XOQbq+eKWEWFy9UevWJ
         5Ai7S+/vlI+JX/x1UdfqVo5H+/lPzu1zCxJWR+q86bAWXSO7gBnQZVld9VucHiJlVqAo
         BSnjACOXFMiZXk4W/PfeuKQEuLlozoXIZjFP+pIjOE+BfPFf3j76ZoIAbwWzwar7Eppp
         V9mGLT2K2zt/axSCwV0Mb3HCHrD1USYmckdCW/Eu7zAG9ZkNliWCARRacpMo+93pGKhN
         0gg/FA8RGF91d5jaFBD4LRb4c+iScFInL47Ad7Tn5y+ZxuVsQQA5pJcTczJP6g3x2zW1
         pmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499586; x=1734104386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQlRSa0gyevRYdEMWu+y6kaDOfqLX2SV11L9Osx2Fq8=;
        b=p/0ocE+5Ypn7zWDwQ/4RmiDwAitDS+VDLDPexj0KQ89ELA/JN4P2/ozrjnjYR74lMM
         ulOzHdhum5Tb93ahqIDAeWB6CpSwpTqtdJPPGuPiupz82yKMFBgbcF6NigK4PF3l4UL4
         FqfcpiRIeVMDTL4walwn7puQ/yVKy5V3XJXBj/tbhJMK+niaPPADbT8NCFrTGSj1xNWK
         7fmrITn4pYZi6quYWDOtUSU3ehO4463nQL9tREtTfryjuySBbFe47/AoaziHlZH1AuKr
         U4BhkR2bPlHYRpNhXvz6kaNVYqUf/M4J1McR7w1Yr7LnLaKG0BAnToeE2pZMTTm4QoIZ
         CeYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ/0L6Cl6lomW4IF2Tg035PElRpoKT2ndDIlYFRdh5u9ac1tz9PIimVpBZzdKGZ2pxeD8n@vger.kernel.org, AJvYcCW6WBaep/bULJOsrDFunB8WeC/bAJCwJ9BA40EZ1kHhAl9aztSRpWcCoudpqrKP1TygdEKfzCvhD7FshA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx50CwqRRgjJR+OT53cxBYYGnggvI/eckkD4y+BJlw/JLx+4PpL
	vLIQ0FVn1JQqGxboxB7Ga1SWQpu1sTzNyR37HqHNCeCwahc9HXR2PExEokFdVEz0I1PYeJvpHAd
	T8RKs7mRnVwun8d3yE/rHX1fhzQU=
X-Gm-Gg: ASbGncvkbsiygpp1+S2Xaxx/QYO0yBxd2oVNStzbHj9gqGPbG5QcLL3naeQ8rRFlgIX
	wduF7gGAIMAVh+dzIWQXb6641b2HtWiww
X-Google-Smtp-Source: AGHT+IFdyaCiflAv7VMwMx2tks5ADj+8BHOIsQjxhnY1q8+dZPnApUh5XzCkXRey4W/pQ0sWE0aKn3KCq3zfiY40G8g=
X-Received: by 2002:a17:906:4d2:b0:aa6:2e99:f430 with SMTP id
 a640c23a62f3a-aa63a17ab64mr216816766b.29.1733499585438; Fri, 06 Dec 2024
 07:39:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+=Fv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=Ei90G98ukRcRJA@mail.gmail.com>
 <f1561626-fde6-41c0-9d45-87a6a7b13816@paulmck-laptop> <CA+=Fv5TMZ1bckob2VZ1AaNwdU3R+5a8REKg4aZR8novx7+dj-g@mail.gmail.com>
 <8e365392-0e0d-4d78-bae7-69f27c8350f9@paulmck-laptop> <CA+=Fv5RKEC6Vabh3bnJfF7D377qL0PTNkWeqSEWqK9DE5GunrQ@mail.gmail.com>
 <51ce38fe2fa34ec79ad07a96feaea597af07bac7.camel@physik.fu-berlin.de> <CA+=Fv5RaMF2ohojG+U0MG-dpLHS4x-Tc41+fOLZwrWqu7T0L0A@mail.gmail.com>
In-Reply-To: <CA+=Fv5RaMF2ohojG+U0MG-dpLHS4x-Tc41+fOLZwrWqu7T0L0A@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 6 Dec 2024 16:39:34 +0100
Message-ID: <CA+=Fv5QH1nUO1D1=Osqic6mNN6vLxiLqvNA4D9uAUgZA_w+7Tw@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some updates on this:

rcu: inside rcu_barrier begin loop first pass cpu index=0
CPU: 1 UID: 0 PID: 1433 Comm: rmmod Not tainted 6.12.1-gentoo #75
        fffffc000a217c88 fffffc0000e62440 fffffc00003a8be8 0000000000000000
        fffffc0000e627b0 fffffc0000e42240 fffffc0000b67c98 fffffc0004a18000

here return address to scsi_host_dev_release is still intact on stack

 rcu: inside rcu_barrier end loop first pass
 CPU: 1 UID: 0 PID: 1433 Comm: rmmod Not tainted 6.12.1-gentoo #75
        fffffc000a217c88 fffffc0000e62440 fffffc00003a8f64 0000000000000000
        fffffc0000e627b0 fffffc0000e42240 0000000000000000 fffffc0004a18000

at the end of first pass in loop, return address in replaced by 0

 rcu: inside rcu_barrier begin loop second pass cpu index=1
 CPU: 1 UID: 0 PID: 1433 Comm: rmmod Not tainted 6.12.1-gentoo #75
        fffffc000a217c88 fffffc0000e62440 fffffc00003a8be8 0000000000000001
        fffffc0000e627b0 fffffc0000e42240 0000000000000000 fffffc0004a18000


 rcu: inside rcu_barrier end loop (second pass)
 CPU: 1 UID: 0 PID: 1433 Comm: rmmod Not tainted 6.12.1-gentoo #75
        fffffc000a217c88 fffffc0000e62440 fffffc00003a8f64 0000000000000001
        fffffc0000e627b0 fffffc0000e42240 0000000000000001 fffffc0004a18000

ant the end of second pass return address is replaced by 1.

It looks like the variable used as loop counter is the value put on the stack
overwriting the return value for scsi_host_dev_release. When adding
a reference to the address of this variable or when it is declared
volatile, stack
corruption does NOT occur.

When examining the disassembly of the code generated from kernel/rcu/tree.o
the most significant difference I can see is that in the case of a
corrupted stack
the frame pointer register $fp is used to hold a reference to the loop
count variable
but in the case with no stack corruption a regular "saved register" is
used for the
reference. Is it possible that the frame pointer is somehow altered
during the execution
of the code? not really sure how linux/alpha/gcc treats the frame pointer. I've
tried altering -fomit-frame-pointer/-f-no-omit-frame-pointer but so
far not getting
anywhere with that...

/Magnus



Return address to scsi_host_dev_release:
[<fffffc0000b67c98>] scsi_host_dev_release+0xac/0x1cc
