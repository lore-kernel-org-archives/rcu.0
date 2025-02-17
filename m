Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FF4136349;
	Mon, 17 Feb 2025 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739779390; cv=none; b=pi5p/tQ60JhSpCoq6n6/0tgyYlH6r3CTsyUy3Yr5r4vzbpAWIPwTIAFA95dqxUPIIZJPL1ekPGOHQ3dyBOQ0xtDoa9cKYfStAr1KQhmc8JwhVJzxW3RfNvKjZz8V/QIMW6Z97ZTuon7+ZVNcOVvlFxAmfM/IriX7caF0eJGOB9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739779390; c=relaxed/simple;
	bh=YITESrMkl5gIZVhqQAVzmTxhl133WPNjHtcpVo9ZwtI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=afaIOVRIQvpySP4IBGTnhHx/T6+GI44P266JD8/B5ZjgvwjGR+gmh2eoqhSk0OZSc2grW3+iruJtz2bIOPfCOtdQRlniKKZsdz5eyf5eOGlHJu3BnDmbKplKWGLKoWYKo/W11gU24cynf4/Q+HwdFRmscs1SAzB/67/9py0IZ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmXQBxit; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmXQBxit"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e6698667c7so32186566d6.2;
        Mon, 17 Feb 2025 00:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739779388; x=1740384188; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiKpIAjimssGEVvD1dp0cxnmqpVNr2ZLBf4s43nBka4=;
        b=fmXQBxit7Kkriwbq4J+IDW0YvMX9CiiR1Rtf7TUfZqgO9bzH3vI3lFtIMu9QBlj08x
         MIR4QcbSkbFN6EmHCPnjAXuf/kXFT5+FNsR/WaK2UukVARbsjAROOZvrBpyLesPMifLb
         SxzbGocwpDBvyWhzSZU7ZMFnuWGXLqnM1ppmjQo9Ystr59LX4A5wQLfgw/yoDTLPmKc7
         yMR3ppoKM5FEqPrOQL3c83xudeGEN9wXzwn1T4HngIAi2S1bHRAl1q1enHx+hSUYBXit
         HrljPLwE/AR0qDOx86Vi3AKGkrGB5GCPoPHTSH+P2ZCWHiCbU3mikKLRtCkOIb7124Fm
         WlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739779388; x=1740384188;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiKpIAjimssGEVvD1dp0cxnmqpVNr2ZLBf4s43nBka4=;
        b=g30krUqCfb0FjlRm4Gr0c3nPDLA60rGf3HTJgsAILnAxgKS0V9RKrcvNAhPi2xAiUC
         mL9Ot9Y3u1HZ1MKG+DlBzxoP59W5NaecKMOea01pxJOBiwILJPC23GNh3t/ttGobD5Gc
         mZLjiV4w4wvWlUgVqte1Rjtx1errhzaZMCKRVnLYXm9aQCs6xqR4a/6Wy9gH0yDDAJCt
         gWgVn4R+VxldKwZa8aav6GxRZl+jfk89Y4bluQ6tkXlboc8YxbU/e1o4uMoHO64hHzDA
         MMSId65QAK93C/DDCz9yEQ7F+mVAjic4h9D8WbbNFLtTbqbMKDBvDKp8I/kqTCm5rZLL
         YAWg==
X-Forwarded-Encrypted: i=1; AJvYcCWCOGixxABzupoFFyQcuk5Z2ttngUI9GL9O9y8V/2bAUwXNwfmTCtKKxC7wc4MfcH36KH2b@vger.kernel.org, AJvYcCXb1Qp19Crq8Q+9Sr4liCZ+zjLHYxGFw+PXRegVNi+QVvyf4t0nANSgp4yI2LjA6Qh2NKu383nznwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGmcKCLdSEI9XVRdmS9OYF54stckwEeca3Aa1n4N+ArPY60Tw3
	5u+yQ+qqmXBfeM1++phy26wFGAerzHBvAB0mVTNuYC6AV4QOXl5P69Kn+Qew
X-Gm-Gg: ASbGncuhOdDFuE8mYnX0fdNAyFIaIdIjg/uaJngglHuC+LS6MPU4U3D8cwh4MFYNbIu
	J2rOY7rru4RUsuPmZDdPqdXa28HVA0vAliQBR3OBaWttn6h4tryznpfrB4qXxaSiC2xNeQTBc1f
	reOCgUzXUnYnU/EH8XwwiYRQ2sSwPKeb5Z5hL9VkVzETVZOSiw4ISzwuIQsyROditYQEDrzLEOT
	W/UBXCjug+VlsVVwOsAH/iUUuWUrULJce239HtehItla6rLm0xaCKLS4FHl8JTpDrvNi8BkMuo=
X-Google-Smtp-Source: AGHT+IESDAtS5/vA7ohng79Q4KWAnLGZ0+Sko2JbErN1DkbAsuzcEFcsugBdxiAVJQJ0sRDN2UznMw==
X-Received: by 2002:a05:6214:d4f:b0:6d8:7ed4:336c with SMTP id 6a1803df08f44-6e66cc89035mr112555346d6.9.1739779387597;
        Mon, 17 Feb 2025 00:03:07 -0800 (PST)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a3c20sm49630626d6.53.2025.02.17.00.03.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2025 00:03:06 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] doc/RCU/listRCU: fix an example code snippets
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <20250217074100.2wyy6akdr2j464wx@master>
Date: Mon, 17 Feb 2025 16:02:53 +0800
Cc: Boqun Feng <boqun.feng@gmail.com>,
 paulmck@kernel.org,
 frederic@kernel.org,
 neeraj.upadhyay@kernel.org,
 rcu@vger.kernel.org,
 linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C6141FF0-5892-439E-9475-43BEF31DFF8E@gmail.com>
References: <20250101082306.10404-1-richard.weiyang@gmail.com>
 <Z7Ka8Z5RS_OwyL_G@Mac.home> <CDB3A2E0-A891-491E-9F7D-F09843F1A3E3@gmail.com>
 <20250217074100.2wyy6akdr2j464wx@master>
To: Wei Yang <richard.weiyang@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

On Feb 17, 2025, at 15:41, Wei Yang <richard.weiyang@gmail.com> wrote:
>=20
> On Mon, Feb 17, 2025 at 10:22:53AM +0800, Alan Huang wrote:
>> On Feb 17, 2025, at 10:12, Boqun Feng <boqun.feng@gmail.com> wrote:
>>>=20
>>> Hi Wei,
>>>=20
>>> The change loosk good to me, thanks!
>>>=20
>>> I queued the patch for futher reviews and tests with some changes in =
the
>>> commit log (for title formating and a bit more explanation), please =
see
>>> below.
>>>=20
>>> Regards,
>>> Boqun
>>>=20
>>> On Wed, Jan 01, 2025 at 08:23:06AM +0000, Wei Yang wrote:
>>>> The example code for "Eliminating Stale Data" looks not correct:
>>>>=20
>>>> * rcu_read_unlock() should put after kstrdup()
>>>> * spin_unlock() should be called before return
>>>>=20
>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> [...]
>>>=20
>>>=20
>>> ------------------>8
>>> Subject: [PATCH] doc/RCU/listRCU: Fix an example code snippets
>>>=20
>>> The example code for "Eliminating Stale Data" looks not correct:
>>>=20
>>> * rcu_read_unlock() should put after kstrdup(), because otherwise
>>> entry may get freed while kstrdup() is being called.
>>>=20
>>> * spin_unlock() should be called before return, otherwise the
>>> function would return with the lock of the entry held.
>>>=20
>>> Hence fix these.
>>>=20
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> Link: =
https://lore.kernel.org/r/20250101082306.10404-1-richard.weiyang@gmail.com=

>>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>>> ---
>>> Documentation/RCU/listRCU.rst | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/Documentation/RCU/listRCU.rst =
b/Documentation/RCU/listRCU.rst
>>> index ed5c9d8c9afe..8df50fcd69fd 100644
>>> --- a/Documentation/RCU/listRCU.rst
>>> +++ b/Documentation/RCU/listRCU.rst
>>> @@ -348,9 +348,10 @@ to accomplish this would be to add a =
``deleted`` flag and a ``lock`` spinlock to
>>> rcu_read_unlock();
>>> return AUDIT_BUILD_CONTEXT;
>>> }
>>> - rcu_read_unlock();
>>> if (state =3D=3D AUDIT_STATE_RECORD)
>>> *key =3D kstrdup(e->rule.filterkey, GFP_ATOMIC);
>>> + spin_unlock(&e->lock);
>>=20
>> According to the above quick quiz, we should return with the lock =
held.
>>=20
>=20
> Thanks, I think you have some reason.
>=20
> If my understanding is correct, the example here is to emphasize we =
could
> still access the value out of critical section but with spinlock held.

This example is intended to highlight how we can eliminate stale data.

>=20
> In current example, we don't return e(struct audit_entry) from
> audit_filter_task(). So no one suppose to release the spinlock again. =
This
> looks to be a mistake.

Then the example code should return e instead. ( *key is also undefined)

If you have some time, I=E2=80=99d recommend [1]

[1] Using Read-Copy-Update Techniques for System V IPC in the Linux 2.5
Kernel

>=20
> My suggestion is to release the lock after kstrdup() to make the =
example more
> intact. But with a comment to explain the purpose here.
>=20
> Also I found we miss the second parameter key here.
>=20
> diff --git a/Documentation/RCU/listRCU.rst =
b/Documentation/RCU/listRCU.rst
> index ed5c9d8c9afe..a3e7f8ff3a81 100644
> --- a/Documentation/RCU/listRCU.rst
> +++ b/Documentation/RCU/listRCU.rst
> @@ -334,7 +334,7 @@ If the system-call audit module were to ever need =
to reject stale data, one way
> to accomplish this would be to add a ``deleted`` flag and a ``lock`` =
spinlock to the
> ``audit_entry`` structure, and modify audit_filter_task() as follows::
>=20
> - static enum audit_state audit_filter_task(struct task_struct *tsk)
> + static enum audit_state audit_filter_task(struct task_struct *tsk, =
char **key)
> {
> struct audit_entry *e;
> enum audit_state   state;
> @@ -349,8 +349,11 @@ to accomplish this would be to add a ``deleted`` =
flag and a ``lock`` spinlock to
> return AUDIT_BUILD_CONTEXT;
> }
> rcu_read_unlock();
> + /* With spinlock held, it is ok to access 'e' out
> +                                 * of critial section */
> if (state =3D=3D AUDIT_STATE_RECORD)
> *key =3D kstrdup(e->rule.filterkey, GFP_ATOMIC);
> + spin_unlock(&e->lock);
> return state;
> }
> }
>=20
> Does it make sense to you?
>=20
>=20
> --=20
> Wei Yang
> Help you, Help me


