Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048528315A
	for <rcu@vger.kernel.org>; Mon, 21 Jul 2025 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086440; cv=none; b=Upe/iRDq24hSwezp0eRWE4HtrrBmpBkktPdGueXjmDwRslHagc5MFDGUC9G8Ut1OeC5DZMoIRNyy4U/prPqKCY8l6MmKINAiNkrN7u5LnyMzkhDqSOaAXHdckDMVI5ESQyYJv5vtQOYq7R82w+GZKPYaFlGn+MAvYkGf3Bz2fbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086440; c=relaxed/simple;
	bh=RBv9fk0/5szEH5fYfYL9K4i2DawNtHAPuulxFPKeGbM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=AxQkADjLrpJyJT/AbOXr5lmTpjN79v6EipndM2hswnBzuTuAxvjqpcGawetjby2A9ERqFT+s8l03b48W+pupY56Tcu/wFrZGNTgRuryCTchblC5eE79jASsW6CE97p9U5/ul7fICgh3aqox3yMqPwNNIHsMnyxyenaUFdXFOB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=xsyUQ/tH; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xsyUQ/tH"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e32c95775aso408702085a.3
        for <rcu@vger.kernel.org>; Mon, 21 Jul 2025 01:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1753086436; x=1753691236; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/odcKAEmFXyMNrSMxdYfCowLIbfS48TF5S5CI5CnjPI=;
        b=xsyUQ/tHpmQ+w8j4LsYZc9tWL8UFrY0SkT/OE496+4vP4BnkT7Tx1lcaXyz8n8yjwc
         pZzngMGr1HUkLf96essJ5IdBVEAf+N1bsnux0CWNWYKKgDLYBweqNQldBCWHlh0Btda3
         6g+dCKgyFT7xY3T3AlR4cp7q8j3hYlfNH9Y7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753086436; x=1753691236;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/odcKAEmFXyMNrSMxdYfCowLIbfS48TF5S5CI5CnjPI=;
        b=o2dJNbz6gu2V2ACpJ8U1sjoyRvRNU/aNhp7OJ6/ikd3XPH0VyVCjZgP0K0kBtftDMC
         0hRmI/OCCm5XDvCNGQVpBkjz3cjW0uRW25HkzHCHAcmTDKtgZKBD0Qda/6ePC5dqfP86
         Po4OcnToV3fpoo6yuvizVEeP+/kG8j1MB/7DeRYfOXx9vyQsiANRth1WYJ9X8I4eMDBP
         lHCJdjMHnNpI0hikMvtpAu5IIFK8X+6dkVxh8jwdRALIj+18hXx3J5UjhkXlBoCaafTB
         eXOVRaJWFVv6CSeAmF5Nn3pfbRkDKI4rQwGj3SJdRZbU7bV6/v9TAyyrVXqfgmWblyQy
         HYXA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ5SvcXuO6Sy/NCZ/H/WASiQ6At/C3VOuiHGqhfqy1SXvD1i7Jn7/eYTeFZ38yDzPxWc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk+mgwCWKFkBNy7QFpwvvWGZ/hZuhIAV1b0oneNRIBIGeDH6Dj
	s3d8wNG/VI2qf50w1XA7jvBtMMuWdA4a1ECYGcTtLhW50Q71y3Jne7jpdW0OZMXWkudtx19QGb3
	SV+9Z
X-Gm-Gg: ASbGncs7tQUUs5kJ9jWKHKX2NVpkO/FWdVbI5dGDGSE5a5EGWovMFNoeHfnaW5AviOO
	BrWD7yPgGNwzITlOqP+u4ovJP78p4CVxKYlZ+erTFn+PXTTq9U3eRVGR38hEJgKYBf4zm1y5M5w
	sJ4h9giTf7B8W4CFVGpjLRFMmDCq2VYQSkShzFS9LuiJftfjwsOablPyh5TwLKeqJS2LzGlmhsW
	FRijETNOtkGUa4aS8xpOk01adgcqZBV9FT9//1EpKQyx5dUqwah+PPCjV4HTiLJdMWd8nZPXCw6
	UcUc09OZ1/HGyflYZLBX8iQUfRIMk8LgMiBiwZ+OF2QV4KKbUGjTy5SnILaowLXvAU/HPYIxFPw
	KAIBstKr3rrEj7vGrlr/oYF/NRHseG8QhZQiyrAtDrtRQk7x03ud+
X-Google-Smtp-Source: AGHT+IHbpPzBeQV8pR+BUFeuByOVOFSZa2i1bRfXbW08DvV0AlP+I06Rjyv/ga6t1AC/b/OjAPmsuw==
X-Received: by 2002:a05:620a:46a6:b0:7e1:5efc:6f6 with SMTP id af79cd13be357-7e343633b0bmr2801006985a.47.1753086436100;
        Mon, 21 Jul 2025 01:27:16 -0700 (PDT)
Received: from smtpclient.apple ([71.51.186.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c3eb74sm390618985a.62.2025.07.21.01.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 01:27:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next 0/6] Patches for v6.17
Date: Mon, 21 Jul 2025 04:27:04 -0400
Message-Id: <A85925F6-3F1D-4D7A-9345-7E20512ADB21@joelfernandes.org>
References: <CAFwiDX9K8T4uDRCmp3R+TqBaKO_jtXwcaeFYdpg-9C5MVJAo4Q@mail.gmail.com>
Cc: Akira Yokosawa <akiyks@gmail.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 paulmck@kernel.org, rcu@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>
In-Reply-To: <CAFwiDX9K8T4uDRCmp3R+TqBaKO_jtXwcaeFYdpg-9C5MVJAo4Q@mail.gmail.com>
To: Neeraj upadhyay <neeraj.iitr10@gmail.com>
X-Mailer: iPhone Mail (22F76)



> On Jul 21, 2025, at 12:29=E2=80=AFAM, Neeraj upadhyay <neeraj.iitr10@gmail=
.com> wrote:
>=20
> =EF=BB=BFHi,
>=20
> On Sun, Jul 20, 2025 at 10:01=E2=80=AFAM Akira Yokosawa <akiyks@gmail.com>=
 wrote:
>=20
> ...
>=20
>> There seems to be a couple of issues in the S-O-B chains of commits liste=
d
>> below (in rcu/next):
>>=20
>> * dcf1668449c9 ("rcu: Document GP init vs hotplug-scan ordering requireme=
nts")
>> * bb1c373934db ("rcu: Document concurrent quiescent state reporting for o=
ffline CPUs")
>>=20
>> They have a "Co-developed-by:" tag without a corresponding "Signed-off-by=
:"
>> tag [1].
>>=20
>> Or, if the contribution is too minor to have a "Signed-off-by:",
>> then a "Suggested-by:" tag with a "Link:" to the relevant message should
>> suffice.
>>=20
>> I have no idea which approach suits better in each commit above.
>>=20
>> [1]: Documentation/process/submitting-patches.rst
>>     section "When to use Acked-by:, Cc:, and Co-developed-by:"
>>=20
>=20
> Thanks for reviewing this! I will fix the tags.
>=20
>=20
>> Quoting relevant paragraph:
>>=20
>>  Co-developed-by: states that the patch was co-created by multiple develo=
pers;
>>  it is used to give attribution to co-authors (in addition to the author
>>  attributed by the From: tag) when several people work on a single patch.=
  Since
>>  Co-developed-by: denotes authorship, every Co-developed-by: must be imme=
diately
>>  followed by a Signed-off-by: of the associated co-author.  Standard sign=
-off
>>  procedure applies, i.e. the ordering of Signed-off-by: tags should refle=
ct the
>>  chronological history of the patch insofar as possible, regardless of wh=
ether
>>  the author is attributed via From: or Co-developed-by:.  Notably, the la=
st
>>  Signed-off-by: must always be that of the developer submitting the patch=
.
>>=20
>> Side note:
>>  scripts/checkpatch.pl would have complained about those missing
>>  Signed-off-by: tags.
>>=20
>>>=20
>>> .../Data-Structures/Data-Structures.rst       |  32 +++++
>>> .../RCU/Design/Requirements/Requirements.rst  | 128 ++++++++++++++++++
>>=20
>> I'm seeing sub-optimal uses of reST markups in Requirements.rst from kern=
el
>> documentation stand point.
>>=20
>> I'm going to submit a patch or two to improve them, but I can't promise w=
hen.
>> They will likely be only cosmetic cleanups and I'm OK with it upstreamed a=
s
>> it is.
>>=20
>=20
> Thanks!

Thanks, I appreciate that!

- Joel

>=20
>=20
> - Neeraj
