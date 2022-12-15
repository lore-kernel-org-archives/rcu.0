Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C12C4332F
	for <rcu@archiver.kernel.org>; Thu, 15 Dec 2022 22:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLOWQ7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Dec 2022 17:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLOWQ6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Dec 2022 17:16:58 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4664F52150
        for <rcu@vger.kernel.org>; Thu, 15 Dec 2022 14:16:57 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id i20so1287181qtw.9
        for <rcu@vger.kernel.org>; Thu, 15 Dec 2022 14:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1d3kv2uhlJIGf5YFF6mrLkq+qTAs39pyqPNUHXT0LY=;
        b=phD0CuMJi0kYgISSYTnXxXhblXeSrwtSERTX/rvh9Sb0unqLt4ztm9nQOor24kYgrY
         kUs/qmCNrk5f7dW/fkz2QAT47sXsj4dbFvAw5MG6U4ZW2H62Y2uvgMZzsZxDv/QGYZ02
         HvkRaIv0lhlW8aouxmECLplEahipSpFJey4RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1d3kv2uhlJIGf5YFF6mrLkq+qTAs39pyqPNUHXT0LY=;
        b=k1udp2xZufuBVjJlezARgUQbbnhWcPDbME4xMo9lkFN6jkurosim4p7baQElYRy9xp
         trpZUWZIId40HWq7jjznzPKrtVhrPEjDHsT6jkQFuRUMObKFwW/tx3rRRZeflSAingnp
         MRnun82p0K2qhE4aFcuVGQSHIFUtCSFWQ7dkDkps7F0aXnbhxaL20UQKxDMQ7Cn7HGu5
         v6icnOlb2kGEwxtaxVGsbzJkO2kM7U1EXxiUwh5nkr9O8Zav/gtCjarizvGjE6rzg3ZV
         RoRR7ivoBtN0o6Dw8xPCQYww+vIKAlDg+Xk1Y1ngsReAfmbN31OcaQ4Cwyw6vuSo+90f
         5D2g==
X-Gm-Message-State: ANoB5pm+CGFf+nS0dB6np1BUJd6rUmjIZKwfI0JlFekfQXhmQsQ9hr8W
        SjG6MsdBM6uyr2aiyRuezTw27A==
X-Google-Smtp-Source: AA0mqf7N1eO/5Rc5o4JiJ5WKQV79qKmc5taV5xDKiaj0JB+DrmrIiET9gZoxqodyCPobjLJZXB5okA==
X-Received: by 2002:a05:622a:2518:b0:3a8:2e5:5b70 with SMTP id cm24-20020a05622a251800b003a802e55b70mr42123997qtb.34.1671142616308;
        Thu, 15 Dec 2022 14:16:56 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id cq8-20020a05622a424800b003a591194221sm173623qtb.7.2022.12.15.14.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 14:16:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check() comments
Date:   Thu, 15 Dec 2022 17:16:45 -0500
Message-Id: <826527A4-42E6-48AB-80C9-FEC0F330F0BE@joelfernandes.org>
References: <20221215221014.GR4001@paulmck-ThinkPad-P17-Gen-1>
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221215221014.GR4001@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Dec 15, 2022, at 5:10 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Thu, Dec 15, 2022 at 04:42:15PM -0500, Joel Fernandes wrote:
>>=20
>>=20
>>>> On Dec 15, 2022, at 4:39 PM, Paul E. McKenney <paulmck@kernel.org> wrot=
e:
>>>=20
>>> =EF=BB=BFOn Thu, Dec 15, 2022 at 03:33:39PM -0500, Joel Fernandes wrote:=

>>>>> On Thu, Dec 15, 2022 at 3:03 PM Joel Fernandes <joel@joelfernandes.org=
> wrote:
>>>>>=20
>>>>> Hi Paul,
>>>>>=20
>>>>>> On Thu, Dec 15, 2022 at 2:58 PM Paul E. McKenney <paulmck@kernel.org>=
 wrote:
>>>>> [...]
>>>>>>> If the first read section's srcu_read_unlock() and its corresponding=

>>>>>>> smp_mb()  happened before the flip, then the increment of old idx
>>>>>>> would happen only once. The next srcu_read_lock() will read the new
>>>>>>> index. If the srcu_read_unlock() and it's corresponding smp_mb()
>>>>>>> happened after the flip, the old_idx will be sampled again and can b=
e
>>>>>>> incremented twice. So it depends on how the flip races with
>>>>>>> srcu_read_unlock().
>>>>>>=20
>>>>>> I do understand that a number of people like reasoning about
>>>>>> memory-barrier ordering, courtesy of the sequentially consistent port=
ions
>>>>>> of the C and C++ memory models, but thinking in terms of the accesses=

>>>>>> surrounding the memory barriers has been far less error-prone.
>>>>>=20
>>>>> Sure, but we are already talking in terms of the access to idx right?
>>>>> That's what we're saying is visible by memory barriers and we are
>>>>> trying to reason here about the ordering (flip does the write to idx
>>>>> and followed by smp_mb(), and there is corresponding read of idx on
>>>>> the srcu_read_lock() side. So we are indeed talking in terms of
>>>>> access, but let me know if I missed something.
>>>>>=20
>>>>>>> Also, since this is all hard to reason about I started making some
>>>>>>> diagrams, LOL. For your amusement, here is why need to scan both idx=

>>>>>>> during grace period detection: https://i.imgur.com/jz4bNKd.png
>>>>>>=20
>>>>>> Nice!
>>>>>>=20
>>>>>> I suggest placing a gap between GP 2 and GP 3.  That way, you can mak=
e it
>>>>>> very clear that Reader 1's critical section starts after the end of G=
P 2
>>>>>> (thus clearly never blocking GP 2) and before GP 3 (thus possibly hav=
ing
>>>>>> a reference to some data that is going to be freed at the end of GP 3=
).
>>>>>>=20
>>>>>> I also suggest coloring Reader 1 red and Reader 2 green, given that t=
he
>>>>>> color red generally indicates danger.
>>>>>=20
>>>>> Thanks for these suggestions! I will make the update. I am planning to=

>>>>> make a number of diagrams for other scenarios as well, as it helps
>>>>> visualize. Google drawing is nice for these. I am happy to share these=

>>>>> with you all if there is interest :).
>>>>=20
>>>> I made these updates, please see: https://i.imgur.com/hoKLvtt.png
>>>>=20
>>>> Feel free to use the image for any purpose and thanks ;-)
>>>=20
>>> Very good, thank you!
>>>=20
>>> Would it be possible to have an arrow marked "X" or "reference to X"
>>> from the beginning of the 'Mark "x" for GC' box to the box labeled
>>> 'Enter RSCS (access "X")'?
>>=20
>> I am currently away from desk. I shared the google drawing with you. Coul=
d you check and make the change, if that=E2=80=99s ok with you?
>>=20
>> Thank you so much,
>=20
> I took a cut at it.  Thoughts?

Yes perfect now :) and handy future reference! Thanks!

- Joel

>=20
>                            Thanx, Paul
