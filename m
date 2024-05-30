Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE6417C201;
	Thu, 30 May 2024 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717075702; cv=none; b=qBduUiynnJ/WyjDg5mF7lxDiEOxLgst9iCKj3gSiNuwGZX5DbStV89ZvPACBxQMa0VC75kYwOlT5G9Pl32Xs+MNvqzOeWvwOfOyjcRJA6twj7wntjnRou7olm1+r7Z89KU1FH2Rn6Xi8dzqLDMQPcuugXe0CkZZb/GlsPtGlvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717075702; c=relaxed/simple;
	bh=O3BgrCQplvhzyHxO9g26AKv4H545ShPXLbjYP3FXx3E=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=MgrYKgHKr6V1K9U/vEM2vcL6ZI53uLxAicCdZ/PMEC6B8YF8oeauGys9x3/305k9X8D8zsdZGARQ7OSh9ZGVpCaKCX6BgEvQ9ESGqEeWXUS3UItI7CWjjJH/RcrCX6v0AeFJeQ0u2uoC7PhaX5HSy3RWR9wNT2Q58VIV8ZsRf7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=aSVCkjnJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Plt2uIiL; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="aSVCkjnJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Plt2uIiL"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id BD19F13800F1;
	Thu, 30 May 2024 09:28:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 30 May 2024 09:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1717075699; x=1717162099; bh=+jLxTCnWUt
	1Hir5+sNhTu9b2ULSOzRhP7WDq2X303Q0=; b=aSVCkjnJmR+ugbr/EoBmBDWeVl
	G7coT7DjI6MH4KQohhe5nGSeL4kl3L82kYzRaHaK72z206pDnhx7W9FOsvMlP3h3
	Xzd2uNubWbVlGqsj1/XugNwp8iI9UPsPs7AqrOInfR7KZlY3g8LiEciPgBV14OeZ
	2hnvZMEFqvzUSXqebeokk2m7HgRXUKVApSkLFOMYa/blLZLwm3oouhzIhawHbTH5
	Oqvez7tBhpGH+NzU3t0M5UVh61vzbl11RF+GiAjb1cTxSTIlQ1S4NVWpEWDgi94n
	rt1YCyudsqMrzaQwMk36sO9KnmRHlvW/zzKIijzIr62mmCqzyTw0ZbYUZKew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717075699; x=1717162099; bh=+jLxTCnWUt1Hir5+sNhTu9b2ULSO
	zRhP7WDq2X303Q0=; b=Plt2uIiL7fKwDpzwEDVi4jQdDTnh2hOsqmssQEoyn5wd
	z3nNHZvdzW7cBVPM1ZO7Macpsbq1D1DjEsolEMwZdAXdSfZb00z/5r/mxM2MHI3D
	GPXOQOc68IndPWs40T/eDEMUwg1iiXAf6hcBbnhcpfAnt442KM6vjh2ztORgDsMX
	GyV+qI9ZevBRiis445z6Chs60V7f54v5f4nmZMbTqoPbbEILN5DYwcvDIFi+SzUl
	vCKyfVp0Zf5VNWhsoCW8n1+tVqu/kF9ZvdGgbjIgILhvf5DRd/zH7LcffeqOXjt9
	IluzhtQ13Pbx/h1dw5snQ9PUisvAgi8BSzZ4CsKmgA==
X-ME-Sender: <xms:835YZkoRamkLJm4sI8N6D-97S_2rtVeZsrpMQ3lJaelIqpowz4Ejtw>
    <xme:835YZqr035GYHk2NwTljBucIu4Vky1z4NNk73-PdM3V8z_1K6PO5hdOHBQPFuWknC
    HB4qVYd4vHuVQy4Qy4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:835YZpNAREJEA7fBndi1XwF1QFzdkF-vhLn9II1mc05Ha7KoQRAIhw>
    <xmx:835YZr78es8Zn8L8du-gfSH5O-IIr16mgNR37QuXs_teo4FRaJMmTw>
    <xmx:835YZj4V3NX563qFeStarBvQnFDJ9_AJrgwBT37E3JxpA_oA26xmQA>
    <xmx:835YZrhb2aNHXtoiTwPi5mFJNG3LYNIJeaHCFlfvnxBER2uFRgFXvA>
    <xmx:835YZnjM3RpmsO8y_v9ip1_f280I5IUQZ5HlPMf0fISe_2cpSm69XTZo>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3A9A8B6008D; Thu, 30 May 2024 09:28:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7f61cc11-7afe-46ac-9f07-62e0b9ab429f@app.fastmail.com>
In-Reply-To: <Zlhwe5owmbzI3jJK@shell.armlinux.org.uk>
References: 
 <CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com>
 <Zlhwe5owmbzI3jJK@shell.armlinux.org.uk>
Date: Thu, 30 May 2024 15:27:58 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Russell King" <linux@armlinux.org.uk>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>
Cc: "open list" <linux-kernel@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>, rcu <rcu@vger.kernel.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Joel Fernandes" <joel@joelfernandes.org>, eeraj.upadhyay@kernel.org,
 "John Ogness" <john.ogness@linutronix.de>
Subject: Re: arm-linux-gnueabihf-ld: kernel/rcu/update.o:update.c:(.text+0x1cc4): more
 undefined references to `__bad_cmpxchg' follow
Content-Type: text/plain

On Thu, May 30, 2024, at 14:26, Russell King (Oracle) wrote:
> On Thu, May 30, 2024 at 05:50:52PM +0530, Naresh Kamboju wrote:
>> The arm builds failed on Linux next with gcc-13 and clang-18.
>> 
>> Config: arm imx_v6_v7_defconfig - failed
>> 
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> 
>> Build log:
>> -----
>> arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
>> `rcu_trc_cmpxchg_need_qs':
>> update.c:(.text+0x348): undefined reference to `__bad_cmpxchg'
>> arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
>> `rcu_read_unlock_trace_special':
>> update.c:(.text+0x41c): undefined reference to `__bad_cmpxchg'
>> arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
>> `trc_read_check_handler':
>> update.c:(.text+0x4b0): undefined reference to `__bad_cmpxchg'
>> arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function `trc_inspect_reader':
>> update.c:(.text+0x1518): undefined reference to `__bad_cmpxchg'
>> arm-linux-gnueabihf-ld: update.c:(.text+0x1548): undefined reference
>> to `__bad_cmpxchg'
>> arm-linux-gnueabihf-ld: kernel/rcu/update.o:update.c:(.text+0x1cc4):
>> more undefined references to `__bad_cmpxchg' follow
>> make[3]: *** [/builds/linux/scripts/Makefile.vmlinux:34: vmlinux] Error 1
>
> You get a reference to __bad_cmpxchg() when someone uses cmpxchg() on
> a datatype that there are no CPU instructions to perform the atomic
> compare-and-exchange.
>
> As we support 8-bit, 16-bit and 32-bit, I would expect that we're now
> seeing cmpxchg() being used on 64-bit values, which are unsupportable
> on 32-bit Arm.

A 64-bit cmpxchg() would fail on most 32-bit architectures,
other than armv6k+ and i686+. Since this one fails on
an armv6 (non-6k) build, it's probably the added 8-bit
cmpxchg() that Paul talked about using for RCU, though I
don't see that in linux-next here.

I htink we need to use the emulated cmpxchg8() in
__cmpxchg() for this case, just like we do on other
architectures that only have word size atomics.

      Arnd
