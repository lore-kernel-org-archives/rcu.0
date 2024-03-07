Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05E5C89
	for <rcu@vger.kernel.org>; Thu,  7 Mar 2024 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779445; cv=none; b=EWw7GKmED+0//LD6W+JWGDyd7w5mmenHgg3Y33vS2CkHRqI0mjpmkeH8yrH9zx+NyeBXDXLAGx35a98ee8JtPTs+FIKAdOwCWKCvjkhVzkjwFAScI3B9PTaW+Zudj6oNHdfUC0z2D2y3N2tA2HGGZpNw5eUjaUZAxQcNwnUywhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779445; c=relaxed/simple;
	bh=zV/eWO1YR+/MLdUcmWtn+zHFWG88UIj9WbZI1A7krRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqZGyFIiDE95m5hg8oH+KFR3yLhx+/dzNc6TP3w4KAEpSZpLYzaw5irf5XmfvVdma07LjQDLl93l9UJxML8gNJKAOTqEbvQaf6TpNVwz8S9G9c6DkuqxDCOrDLXkwlMtsbkQtQv3XPTVjT9S/pAGZrtiEOCYxf5S7NxPV+AQVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FHlKPiqP; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FHlKPiqP"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513298d6859so358493e87.3
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 18:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709779441; x=1710384241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x8aBTmS0uzOVB2zuwBnhmAk7ClNR7ZgZluXdpxoMOVc=;
        b=FHlKPiqPv38116xrCRByqhc4U/G9UNb6GrnQJz4JNPL7uZQ7wGYPO4zIfSmxjpL5Dc
         4OR/8KEQhTaPnx9Z13Z+XvhrGAkmfS4msBH7eDmdXXoJUEPZL59ypMwfHpoSe4yWTJr9
         Lujb3qXAWrLSbP+/JtHdkoTSD4Uf+BvX8wT2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709779441; x=1710384241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8aBTmS0uzOVB2zuwBnhmAk7ClNR7ZgZluXdpxoMOVc=;
        b=GnEh/GRvOqqSQTSVvb3BZjv15N0ScM7X4KAzkPbDmfXUMFuniq7B9R3K76HSf+w3Pj
         FDC7+J8jzan6r+AXsS4mzgaEpRKvMfAmVsWbPHSjWLiiJ9Brb+k+glYsB60Jw9n+66et
         E7+5uNPRS88ECvqui5u6bENmB3F+iDtoh0+ftizLZwihEAogEzvfoyYX0YmKEMokZwDG
         7Nz2PYZu2q5dKQ+G0XpkHkBLDGEXuAYTOCIjMnrA7Pm0jrzusSwpBOUTjeTcggud1vLT
         APKHTj4bc7sl8yMI7v6KItOoaYxUPP/wbvlKwgMsnstb+MMB9ptZ76sTG/3knS9Vr62P
         /X0g==
X-Forwarded-Encrypted: i=1; AJvYcCVeXNMk7dJ6sEUcki+lmnOpkZvjPTwZuFbZNqYMaQoczpWQG33lwWldMXgdZ9cpuXR6UaS1bRl7YKjd+QBBmjZFYZiG
X-Gm-Message-State: AOJu0YwfVMeJiuxUPKPp/CtJ2EdDJS71U+8TuXW7szuWh9pCyNHRx4vi
	AKNIA3vCH39gf1pXMQZzA7KsFxF3ihQy+P45qQDY9N50vpmtB+q0HBxE3CNezQe3FzOVR7OoEv7
	jaL/RxQ==
X-Google-Smtp-Source: AGHT+IEdr2otEnyQV5ynpNy8+5cz8KCvahe941bvoMTSSfN08GiQdcjJg0sx0Mk/mFsnWDhLXprPYA==
X-Received: by 2002:ac2:5e63:0:b0:513:2ead:4f86 with SMTP id a3-20020ac25e63000000b005132ead4f86mr450379lfr.12.1709779440916;
        Wed, 06 Mar 2024 18:44:00 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u13-20020ac25bcd000000b005132359c699sm2840697lfn.70.2024.03.06.18.44.00
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 18:44:00 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513298d6859so358489e87.3
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 18:44:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDRNJ+q1zr/W6drRmDyDskcvT2vCu9sDGoP2v3FF7/wntj5idRqSVbzUVC+zYf80Cdo7HLvc7AOo6HuyuHZe6GcJi7
X-Received: by 2002:a05:6512:3daa:b0:513:6543:d2a8 with SMTP id
 k42-20020a0565123daa00b005136543d2a8mr586305lfv.16.1709779440068; Wed, 06 Mar
 2024 18:44:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com> <20240306103719.1d241b93@gandalf.local.home>
 <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop> <20240306130103.6da71ddf@gandalf.local.home>
 <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home> <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home> <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
In-Reply-To: <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 18:43:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
Message-ID: <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: paulmck@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang1211@gmail.com, 
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002c51840613090c9d"

--0000000000002c51840613090c9d
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 18:29, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> TL;DR:  Those ->rtort_pipe_count increments cannot run concurrently
> with each other or any other update of that field, so that update-side
> READ_ONCE() call is unnecessary and the update-side plain C-language
> read is OK.  The WRITE_ONCE() calls are there for the benefit of the
> lockless read-side accesses to rtort_pipe_count.

Ahh. Ok. That makes a bit more sense.

So if that's the case, then the "updating side" should never use
READ_ONCE, because there's nothing else to protect against.

Honestly, this all makes me think that we'd be *much* better off
showing the real "handoff" with smp_store_release() and
smp_load_acquire().

IOW, something like this (TOTALLY UNTESTED!) patch, perhaps?

And please note that this patch is not only untested, it really is a
very handwavy patch.

I'm sending it as a patch just because it's a more precise way of
saying "I think the writers and readers could use the store-release ->
load-acquire not just to avoid any worries about accessing things
once, but also as a way to show the directional 'flow' of the data".

I dunno.

           Linus

--0000000000002c51840613090c9d
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ltgmgj3o0>
X-Attachment-Id: f_ltgmgj3o0

IGtlcm5lbC9yY3UvcmN1dG9ydHVyZS5jIHwgMTEgKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL3Jj
dS9yY3V0b3J0dXJlLmMgYi9rZXJuZWwvcmN1L3JjdXRvcnR1cmUuYwppbmRleCA3NTY3Y2E4ZTc0
M2MuLjYwYjc0ZGYzZWFlMiAxMDA2NDQKLS0tIGEva2VybmVsL3JjdS9yY3V0b3J0dXJlLmMKKysr
IGIva2VybmVsL3JjdS9yY3V0b3J0dXJlLmMKQEAgLTQ2MSwxMiArNDYxLDEyIEBAIHJjdV90b3J0
dXJlX3BpcGVfdXBkYXRlX29uZShzdHJ1Y3QgcmN1X3RvcnR1cmUgKnJwKQogCQlXUklURV9PTkNF
KHJwLT5ydG9ydF9jaGtwLCBOVUxMKTsKIAkJc21wX3N0b3JlX3JlbGVhc2UoJnJ0cmNwLT5ydGNf
cmVhZHksIDEpOyAvLyBQYWlyIHdpdGggc21wX2xvYWRfYWNxdWlyZSgpLgogCX0KLQlpID0gUkVB
RF9PTkNFKHJwLT5ydG9ydF9waXBlX2NvdW50KTsKKwlpID0gcnAtPnJ0b3J0X3BpcGVfY291bnQ7
CiAJaWYgKGkgPiBSQ1VfVE9SVFVSRV9QSVBFX0xFTikKIAkJaSA9IFJDVV9UT1JUVVJFX1BJUEVf
TEVOOwogCWF0b21pY19pbmMoJnJjdV90b3J0dXJlX3djb3VudFtpXSk7Ci0JV1JJVEVfT05DRShy
cC0+cnRvcnRfcGlwZV9jb3VudCwgaSArIDEpOwotCWlmIChycC0+cnRvcnRfcGlwZV9jb3VudCA+
PSBSQ1VfVE9SVFVSRV9QSVBFX0xFTikgeworCXNtcF9zdG9yZV9yZWxlYXNlKCZycC0+cnRvcnRf
cGlwZV9jb3VudCwgKytpKTsKKwlpZiAoaSA+PSBSQ1VfVE9SVFVSRV9QSVBFX0xFTikgewogCQly
cC0+cnRvcnRfbWJ0ZXN0ID0gMDsKIAkJcmV0dXJuIHRydWU7CiAJfQpAQCAtMTQwOCw4ICsxNDA4
LDcgQEAgcmN1X3RvcnR1cmVfd3JpdGVyKHZvaWQgKmFyZykKIAkJCWlmIChpID4gUkNVX1RPUlRV
UkVfUElQRV9MRU4pCiAJCQkJaSA9IFJDVV9UT1JUVVJFX1BJUEVfTEVOOwogCQkJYXRvbWljX2lu
YygmcmN1X3RvcnR1cmVfd2NvdW50W2ldKTsKLQkJCVdSSVRFX09OQ0Uob2xkX3JwLT5ydG9ydF9w
aXBlX2NvdW50LAotCQkJCSAgIG9sZF9ycC0+cnRvcnRfcGlwZV9jb3VudCArIDEpOworCQkJc21w
X3N0b3JlX3JlbGVhc2UoJm9sZF9ycC0+cnRvcnRfcGlwZV9jb3VudCwgKytpKTsKIAogCQkJLy8g
TWFrZSBzdXJlIHJlYWRlcnMgYmxvY2sgcG9sbGVkIGdyYWNlIHBlcmlvZHMuCiAJCQlpZiAoY3Vy
X29wcy0+Z2V0X2dwX3N0YXRlICYmIGN1cl9vcHMtPnBvbGxfZ3Bfc3RhdGUpIHsKQEAgLTE5OTEs
NyArMTk5MCw3IEBAIHN0YXRpYyBib29sIHJjdV90b3J0dXJlX29uZV9yZWFkKHN0cnVjdCB0b3J0
dXJlX3JhbmRvbV9zdGF0ZSAqdHJzcCwgbG9uZyBteWlkKQogCXJjdV90b3J0dXJlX3JlYWRlcl9k
b19tYmNoayhteWlkLCBwLCB0cnNwKTsKIAlydHJzcCA9IHJjdXRvcnR1cmVfbG9vcF9leHRlbmQo
JnJlYWRzdGF0ZSwgdHJzcCwgcnRyc3ApOwogCXByZWVtcHRfZGlzYWJsZSgpOwotCXBpcGVfY291
bnQgPSBSRUFEX09OQ0UocC0+cnRvcnRfcGlwZV9jb3VudCk7CisJcGlwZV9jb3VudCA9IHNtcF9s
b2FkX2FjcXVpcmUoJnAtPnJ0b3J0X3BpcGVfY291bnQpOwogCWlmIChwaXBlX2NvdW50ID4gUkNV
X1RPUlRVUkVfUElQRV9MRU4pIHsKIAkJLyogU2hvdWxkIG5vdCBoYXBwZW4sIGJ1dC4uLiAqLwog
CQlwaXBlX2NvdW50ID0gUkNVX1RPUlRVUkVfUElQRV9MRU47Cg==
--0000000000002c51840613090c9d--
