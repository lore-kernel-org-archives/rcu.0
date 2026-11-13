Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574359;
	b=r62o+lHm/2NqnxNmzJoef8U9P2DXGMSPNCHgewVhVLjikDiA2NvKakNK1jQNY0LmouIJ
	 fNxrOzLh6BoEFAOc6eK6cqJ5Qly3lIhPVNVo3CXzZLH4GJovLGEuckLvqY/oznbew9/Si
	 N2ZWvnppKXXKGvr2zUVJSaXZ7hsGbpdwpH8lzGcQF5qjNd7UQ9QI1Il3q03lDrGAkBWNJ
	 s/zYo+u3LMaoVETvT6GKUaSelurevahy9HPu6tfnAkV6G4VN8v+6+26tppwofNGMrL7sy
	 DIrOmECyyjFPtrSh++mQig8JCVg3dQCFGDYzhFL0Cmxpx8tKXuZ4uC/AWptZZ+YJ/bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=vsvfEz/JXaM3emjEVz0W8hj1SjatUIAGiMufiOo3KXw=;
	b=FiABr0li4fzYNst05NStb65GhqT1kAND0VLstGZTmQIvOCbrmgHR2ZtTMV3n1Qvu3plj
	 gWdu/DaodyOZiwHpAm3ctQeZKvZd8oVOrjEryH1Dz23/L4VBlYucf4x5Cjok2FA05Mevl
	 HqV+RZ/ExrmWW5HBRmTikYr8Ml8678QT7o9+fFNpxvNEl3C54NkEopiVn+IAx2znOkQ1s
	 LUQYTI2F3303E2azLusr18Q4e4Mf+KOlYPc2xjPS+yoSv+yj10Qx/SIL2zyRtzD7rrT8s
	 f4gZsG/So+Jq1Ut2YqiMmDJled9uoRvZLyy7rF6IiWyOO/kqXtxjSJHeSMgj9MFhT4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=joelfernandes.org;
	spf=pass smtp.mailfrom=joelfernandes.org;
	dkim=pass header.d=joelfernandes.org header.i=@joelfernandes.org header.a=rsa-sha256 header.s=google header.b=sye1zQCf;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BF1606A333
	for <rcu@vger.kernel.org>; Fri, 13 Nov 2026 12:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73BF1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.a=rsa-sha256 header.s=google header.b=sye1zQCf
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-537548b811aso5443881cf.3
        for <rcu@vger.kernel.org>; Fri, 13 Nov 2026 04:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1794574358; x=1795179158; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vsvfEz/JXaM3emjEVz0W8hj1SjatUIAGiMufiOo3KXw=;
        b=sye1zQCfa/2xWnnilpkHYYKMj3m86qO9jxoV8NCvPRh9QXDt3mmep1Lolke49cTAQ5
         qUKY7lv/YhiFoh1jIm0S2QudRTJ+aZFLJE5LbOYRMfQDxeGUOkA/M2T50YgrnPVaGplr
         x3qpIQOlSRHAdRKse9Er6DsXZZmgGvQYe4hMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574358; x=1795179158;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vsvfEz/JXaM3emjEVz0W8hj1SjatUIAGiMufiOo3KXw=;
        b=bfCDxJ5m6avCmGYeaVcYfKBdnic5vz5J9i54KSkMPpVkzX6rY5WkbopeoDskb/7F9x
         FQGVOsTheJsIkJUuPzma65KA1e5N6TOeI2c9OaP/BSFVVcVEta9GgxSgqihgNUZq234W
         +6y27oIFn6SSXO4za9yPSwea0uAe6T/C7zWutM2P5S3d05+fqK6j/zhTWPpHcX4yN+QV
         fp9ILpD2FPJwhVwc9u5YY1Y3RKhav3t4iHAPvybrgjmPoIi8zd0kPu/c0Dni8RJykxef
         myCFmOGs/NekBI9jfQLyjWgzoXrUbKyrR8GxRbwlCeVKKYc4wTi8t0iRvNUrZKPZ+GTO
         ZiBw==
X-Forwarded-Encrypted: i=1; AL+hErFBHx4uFLzKIbBL1L3vQ5NdC8DId7MsglnZwCqEmW51bS/Pn857EOmFocWk//QU65ffG1o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wbGzgm28j3AhXuDTfhCKFlLXI2NQ/LeQf5Unt7eTDXa/3dVfm
	QOWZWMR4d/vciYnNX2QQUP8vNHQ5eMTSMIgfX0B173ule0DGe3ju7LMkS+B2niZMfkI=
X-Gm-Gg: AYBFou2lGtkqVUtkGVqp7vXS9FXXVeiyqCisGUaP7mtv/F5RynuY5aqfROWBgQ0myxk
	MfdLeURcbxB+2y4v847xj0VA1vv4fWDlGTxggJvT9CXLycgKfkJn7y1YV6m/QkIoadTDoHBaVOB
	w2rZ2jhlsMp9Jlf6eoW+hs9/zz6Y2q5WMKNvCbFplgqpLPQLuuoEEGwgrlSs5lun+SWk2OWNocn
	t+N85HuDKNYo8EHlMbu8NY2igqbHEh2sVNuOV9EWAXpyIfVL66H1A95mGUcCxY4tjDkITZt4y7T
	AORHdB2ulTGKKaVzFHG+VVcUWbePKlyOm/3G1SwqDJu3OIC5yihvepuGqS6zwauQWWlXqV9IwTC
	H/G2mLhAaV1okHeRaU6EC2Q0oeC5uZz8rv5+c9slyWirT0bszasMmY9Hvwccsf3m0FiPmLzL2JV
	kTKjfjIVQjMb8LX0JaSY4UBy/N4CsLiqce/Cg/O5wspjhHjfHB86KlhOfFcbh40RB6UrhAVnIou
	Qa9GcC3d7jCmTGvbtD9QhGmUKV3riYbmjfDAeoV3QUoEX1vjAq8ug+uZhiaIoMJMCtUby/MxErf
	5gJB/Kv62WkQHth7LMUCU2BisWWRpQzn0C1QkJoZLKerJp9u2hgaEmzTftEIHYkRZ/Fr37zX6fy
	8
X-Received: by 2002:ac8:610a:0:b0:537:6f12:69 with SMTP id d75a77b69052e-55ac888b9a3mr39211601cf.45.1794574358087;
        Fri, 13 Nov 2026 04:52:38 -0800 (PST)
Received: from smtpclient.apple ([71.51.169.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0f07afesm17600871cf.16.2026.11.13.04.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:52:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH for-v7.5 00/14] RCU tests patches for v7.5
Date: Fri, 13 Nov 2026 07:52:25 -0500
Message-Id: <13A75D0D-C6FF-4AD1-AB43-734444FB5762@joelfernandes.org>
References: <5F3EC480-DEBB-437D-B433-2361A5CC05E0@linux.dev>
Cc: jfern@kernel.org, boqun@kernel.org, frederic@kernel.org,
 jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rostedt@goodmis.org, urezki@gmail.com
In-Reply-To: <5F3EC480-DEBB-437D-B433-2361A5CC05E0@linux.dev>
To: Bradley Morgan <bradley.morgan@linux.dev>
X-Mailer: iPhone Mail (23G90)



> On Nov 13, 2026, at 2:28=E2=80=AFAM, Bradley Morgan <bradley.morgan@linux.=
dev> wrote:
>=20
> =EF=BB=BFOn 13 November 2026 00:57:27 GMT, Joel Fernandes <jfern@kernel.or=
g> wrote:
>> This series has the RCU tests patches for the v7.5 merge window.
>=20
> Thanx for keeping my tags, mind changing my tags to my new email? If it
> doesn't pain you too much? New email change is a pain...
>=20

Yes will do.



>>=20
>> Fu Wenxin (1):
>> rcutorture: Fix busted_srcud crash on module unload
>>=20
>> Joel Fernandes (5):
>> kasan: Avoid an unrelated RCU warning in the callback test
>> rcuscale: Consolidate per-writer arrays into struct writer_state
>> scftorture: Reject empty workloads before starting helpers
>> scftorture: Protect the initial affinity check from hotplug
>> torture: Forgive SMT-control failures in CPU-hotplug testing
>>=20
>> Kunwu Chan (3):
>> Documentation/litmus-tests: Add SRCU fastpath anchor-before-scan test
>> Documentation/litmus-tests: Add SRCU fastpath scan-before-anchor test
>> rcuscale: Add srcua scale type
>>=20
>> Paul E. McKenney (2):
>> rcutorture: Enable RCU_BOOST where supported
>> rcutorture: Disable RCU priority boost testing on non-TREE03 scenarios
>>=20
>> Zqiang (3):
>> rcutorture: Fix suspicious rcu_dereference_check() usage for
>>   trivial-preempt
>> rcutorture: Make tasks-tracing support duplicate call testing
>> rcutorture: Avoid create fwd_prog_tasks for tasks-rude and srcu-atomic
>>=20
>>=20
>=20
> --- Thanks!
