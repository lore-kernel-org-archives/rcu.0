Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0C21A2547
	for <rcu@vger.kernel.org>; Tue, 22 Oct 2024 22:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635746; cv=none; b=a8DdnTe60HRXHkGY0FssbqONPqeMgl7c11MQWP9IGb6W5/SoTQ2wIAVSKhH5SvRAe5eoAHIBursA6lL3FQqATfM7GH3Q7IfvqZH0c9MpcyKjj2/gWyaDnk/szdTQLijvH8GLSwuEskGAPmoZ3YAoR9XYaRbDIA157hDtVkUVHjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635746; c=relaxed/simple;
	bh=MVapkSi7WwnwYpMTqxMDHtRQp6648YIQQ+l56D+yQjg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IkZyB9oORHpckzxW6cJuHKX7sLondg4vw764WL26X3riGoe9Ss/lEJF6Oyem6+kzJOf3Q0mS8alMxfXgPVoTV44IdAJvTTF5N7GQ17TxPMrGr1rBjTqg28GM2JtcAIlX405A7RftT4PkHlwrowwtIIIuZ1Fhe42RjkCzLr5VJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLqFysLx; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLqFysLx"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71f5208217dso744416b3a.2
        for <rcu@vger.kernel.org>; Tue, 22 Oct 2024 15:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729635744; x=1730240544; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IAurXDQos6UC8Kz9RYticBS0uwxPsZxZpB5uXwa/g/k=;
        b=gLqFysLxSF6BDv9SAaqeXQyNVal7PbeFVsvS0k/zf0yEywTGrZZ9zWoLnrXLjM/wiy
         3088exYZKK48q8FW4x1tLWoi7Eqy2WyZ+x1m4ziohV2ml7R4k6mnO8rS6bLYQaTj+kyC
         NzmXW7ORuv3sOTVYox6WJsYdS5J6Rdf8MiJMd+IjlyIMapZQTJNd+WtDrnbVVbfWEyN1
         smBIhiseXBYnTlZR1VvN2KYLIPALTkdypaBiq8q4ZTOb6YS6ZsY06cTrtDisteWL8hQ/
         vAf83Lsry30x+d1Lvil+q2L2eVjdkImbyn/khx1bMGeVVXoJsIg2anpfXuF0I84vFgLk
         tr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729635744; x=1730240544;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IAurXDQos6UC8Kz9RYticBS0uwxPsZxZpB5uXwa/g/k=;
        b=kDzvYR4qunZSGJ7a9QIiOqR0P0SJjHJbcrKqALTw+hgWRfFOPctQSOd9dEmBLFb+DF
         9Qsi6SY0yCVhCpbbYFhhGOhV+MOcxhTisy7G90z2xmoA/87Ti+ZLc+Jdg15k5NO/E6Og
         wPI97modKYHIOhQTJMvHglr52xAYMabMAKIY4sF+Zc4LCQYDPtDu4fwIVRlnejlilP7v
         gJQSGEE6ukqnqjBLpU1MZcGrT0BQevspgElo0NJqeVJhabFFH28mkQWAL1rUf9z9Yam+
         EWAgXpA0qCwwbVUFrCSKuMiiyPR1cvyaQ2BeSNh2fVqmV2SIIitwkYtsfJfBAVnypFNm
         qxCw==
X-Gm-Message-State: AOJu0YwdG2uvzmXULCWcq7PZyDcZuK0b9mK87Ws7NnUi2Cvrdj4SCtCX
	0ejd2s2rviWWKMiLHcEgzdObcCclnikjNXa37Vq569ZdHUJdQHIIaI7t4nKnbciNsh3Zn5+p8F/
	8kV+Ae7GsBg7oxiPhDxNS5i+2hIb/OSgQ
X-Google-Smtp-Source: AGHT+IE4rhAWJTpc005yoyANoSQh4U5y5BijVWdxKpC8nppzgUfVKmJ1aSFVPMS7wPIxD9jFpKWMC6Ak8mURZ9htGzk=
X-Received: by 2002:a05:6a00:4fd4:b0:71e:780e:9c1 with SMTP id
 d2e1a72fcca58-72030b7b971mr961070b3a.18.1729635743863; Tue, 22 Oct 2024
 15:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shane Miller <gshanemiller6@gmail.com>
Date: Tue, 22 Oct 2024 18:21:47 -0400
Message-ID: <CAFtQo5By2EjXrjzdmx=dEt9k+20EjEGuwdEAZ4fB3=8H37tp=Q@mail.gmail.com>
Subject: re: defer_rcu() usage
To: rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I've used the qsbr flavor of urcu with success. It works great. The
doc, benchmark code make clear that RCU writers,

* must use rcu_xchg_pointer() or rcu_assign_pointer() to update data structure
* must call 'synchronize_rcu()' which blocks until readers are out of
critical section on old copy so that the old data structure can be
cleaned up.

However, synchronize_rcu() is not giving me the write performance I want.

But 'tests/benchmark/test_urcu_defer.c' does - cool!

Regrettably, the doc on 'defer_rcu' just isn't clear to me. When
'defer_rcu' runs the callback specified in its arguments can I
conclude, like 'synchronize_rcu()' that there are no/none/zero readers
in a critical section on the old data structure?

Is this the intended usage?

```
void deferCallBack(void *oldData) {
 Foo *old = (Foo*)oldData;
  // In this function I know for sure no RCU reader
  // is in a critical section in 'old'. I can free/mutate
  // it as needed
  . . .
}

void rcuWriterLoop() {
  rcu_defer_register_thread();
  while (!done) {
    Foo *newCopy = ....
    // Prior to this line readers are not in a read critical section (CS)
    // or in CS on 'old'. On return readers are not in a CS or in
    // a CS in newCopy only.
    Foo *old = rcu_xchg_pointer(&current, newCopy);
    // Cleanup 'old': readers can't be accessing it
    defer_rcu(deferCallBack, old);
  }
  rcu_defer_unregister_thread();
}
```
